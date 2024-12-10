# frozen_string_literal: true

require_relative 'export_kick_off_performer'
require_relative 'bulk_data_test_kit_properties'

module BulkDataTestKit
  module BulkDataExportOperationTests
    extend Forwardable

    def_delegators 'self.class', :properties
    def_delegators 'properties',
                   :resource_type,
                   :bulk_export_url

    def check_export_support
      fhir_get_capability_statement(client: :bulk_server)
      assert_response_status([200, 201])

      assert_valid_json(request.response_body)
      capability_statement = FHIR.from_contents(request.response_body)

      warning do
        has_instantiates = capability_statement&.instantiates&.any? do |canonical|
          canonical.match(%r{^http://hl7.org/fhir/uv/bulkdata/CapabilityStatement/bulk-data(\|\S+)?$})
        end
        assert has_instantiates,
               'Server did not declare conformance to the Bulk Data IG by including ' \
               "'http://hl7.org/fhir/uv/bulkdata/CapabilityStatement/bulk-data' in " \
               "CapabilityStatement.instantiates element (#{capability_statement&.instantiates})"
      end

      group_resource_capabilities = nil

      capability_statement&.rest&.each do |rest|
        group_resource_capabilities = if resource_type == 'system'
                                        rest
                                      else
                                        rest.resource&.find do |resource|
                                          resource.type == resource_type
                                        end
                                      end
      end

      assert group_resource_capabilities.respond_to?(:operation) && group_resource_capabilities.operation&.any?,
             "Server CapabilityStatement did not declare support for any operations on the #{resource_type} resource"

      has_export_operation = group_resource_capabilities.operation&.any? do |operation|
        name_match = (operation.name == 'export')
        operationDefURL = resource_type == 'system' ? 'export' : "#{resource_type.downcase}-export"

        if name_match && !operation.definition&.match(%r{^http://hl7.org/fhir/uv/bulkdata/OperationDefinition/#{operationDefURL}(\|\S+)?$})
          info("Server CapabilityStatement does not include export operation with definition http://hl7.org/fhir/uv/bulkdata/OperationDefinition/#{operationDefURL}")
        end
        name_match
      end
      warning do
        assert has_export_operation,
               "Server CapabilityStatement did not declare support for an operation named export in the #{resource_type} " \
               'resource (operation.name should be export)'
      end
    end

    def rejects_without_authorization
      skip_if bearer_token.blank?, 'Bearer token is not set and thus not required to connect to server.'

      url = bulk_export_url.dup
      if resource_type == 'Group'
        skip_if group_id.blank?, 'Group id is blank, skipping test.'
        url = bulk_export_url.gsub('[group_id]', group_id) if resource_type == 'Group'
      end

      perform_export_kick_off_request(use_token: false, url:)
      assert_response_status([400, 401])
    end

    def export_kick_off_success
      use_token = !bearer_token.blank?

      url = bulk_export_url.dup
      if resource_type == 'Group'
        skip_if group_id.blank?, 'Group id is blank, skipping test.'
        url = bulk_export_url.gsub('[group_id]', group_id) if resource_type == 'Group'
      end

      perform_export_kick_off_request(use_token:, url:)
      assert_response_status(202)

      polling_url = request.response_header('content-location')&.value
      assert polling_url.present?, 'Export response headers did not include "Content-Location"'

      polling_url
    end

    def export_status_check_success(status_polling_url)
      skip 'Server response did not have Content-Location in header' unless status_polling_url.present?

      timeout = bulk_timeout.to_i

      if !timeout.positive?
        timeout = 180
      elsif timeout > 600
        timeout = 600
      end

      wait_time = 1
      start = Time.now
      used_time = 0

      loop do
        get(status_polling_url, headers: { authorization: "Bearer #{bearer_token}", accept: 'application/json' })

        retry_after_val = request.response_header('retry-after')&.value.to_i

        wait_time = retry_after_val.positive? ? retry_after_val : wait_time *= 2

        used_time = Time.now - start

        total_time_to_next_poll = Time.now - start + wait_time

        break if response[:status] != 202 || total_time_to_next_poll > timeout

        sleep wait_time
      end

      if response[:status] == 202
        skip "Server already used #{used_time} seconds processing this request, " \
            "and next poll is #{wait_time} seconds after. " \
            "The total wait time for next poll is more than #{timeout} seconds time out setting."
      end

      assert_response_status(200)

      assert request.response_header('content-type')&.value&.include?('application/json'),
             'Content-Type not application/json'

      assert_valid_json(response[:body])
      response_body = JSON.parse(response[:body])

      %w[transactionTime request requiresAccessToken output error].each do |key|
        assert response_body.key?(key), "Complete Status response did not contain \"#{key}\" as required"
      end

      requires_access_token = response_body['requiresAccessToken'].to_s.downcase
      status_response = response[:body]

      [requires_access_token, status_response]
    end

    def check_bulk_data_output(export_status_response)
      assert export_status_response.present?, 'Bulk Data Server status response not found'

      assert_valid_json(export_status_response)
      status_output = JSON.parse(export_status_response)['output']
      assert status_output, 'Bulk Data Server status response does not contain output'

      skip_if status_output.empty?, 'Bulk Data Server status response does not contain any data in the output'

      begin
        status_output_json = status_output.to_json
        bulk_download_url = status_output[0]['url']

        [status_output_json, bulk_download_url]
      ensure
        status_output.each do |file|
          %w[type url].each do |key|
            assert file.key?(key), "Output file did not contain \"#{key}\" as required"
          end

          if config.options[:require_absolute_urls_in_output]
            assert file['url'].to_s.match?(%r{\Ahttps?://}),
                   "URLs in output file must be absolute, but found `#{file['url']}`."
          end
        end
      end
    end
  end
end
