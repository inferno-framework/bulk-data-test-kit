# frozen_string_literal: true

module BulkDataTestKit
  module BulkExportValidationTester
    attr_reader :metadata

    MAX_NUM_COLLECTED_LINES = 100
    MIN_RESOURCE_COUNT = 2

    def resources_from_all_files
      @resources_from_all_files ||= {}
    end

    def first_error
      @first_error ||= {}
    end

    def patient_ids_seen
      scratch[:patient_ids_seen] ||= []
    end

    def resource_type
      @resource_type ||= ''
    end

    def validation_errors
      @validation_errors ||= []
    end

    def build_headers(use_token)
      headers = { accept: 'application/fhir+ndjson' }
      headers.merge!({ authorization: "Bearer #{smart_auth_info.access_token}" }) if use_token == 'true'
      headers
    end

    def stream_ndjson(endpoint, headers, process_chunk_line, process_response) # rubocop:disable Metrics/CyclomaticComplexity
      hanging_chunk = String.new

      process_body = proc { |chunk|
        hanging_chunk << chunk
        chunk_by_lines = hanging_chunk.lines

        hanging_chunk = chunk_by_lines.pop || String.new

        chunk_by_lines.each do |elem|
          process_chunk_line.call(elem)
        end
      }

      stream(process_body, endpoint, headers:)

      max_redirect = 5

      while [301, 302, 303, 307].include?(response[:status]) &&
            request.response_header('location')&.value.present? &&
            max_redirect.positive?

        max_redirect -= 1

        redirect_url = request.response_header('location')&.value

        # handle relative redirects
        redirect_url = URI.parse(endpoint).merge(redirect_url).to_s unless redirect_url.start_with?('http')

        redirect_headers = headers.except(:authorization)

        stream(process_body, redirect_url, headers: redirect_headers)
      end

      process_chunk_line.call(hanging_chunk)
      process_response.call(response)
    end

    def check_file_request(url, bulk_requires_access_token) # rubocop:disable Metrics/CyclomaticComplexity
      line_count = 0
      resources = Hash.new { |h, k| h[k] = [] }

      process_line = proc do |line|
        next unless lines_to_validate.blank? ||
                    line_count < lines_to_validate.to_i ||
                    (@resource_type == 'Patient' && patient_ids_seen.length < MIN_RESOURCE_COUNT)

        line_count += 1

        begin
          resource = FHIR.from_contents(line)
        rescue StandardError
          skip "Server response at line \"#{line_count}\" is not a processable FHIR resource."
        end

        assert !resource.nil?,
               "Resource at line \"#{line_count}\" could not be converted to a #{@resource_type} FHIR resource"

        if resource.resourceType != @resource_type
          assert false, "Resource type \"#{resource.resourceType}\" at line \"#{line_count}\" does not match type " \
                        "defined in output \"#{@resource_type}\""
        end

        scratch[:patient_ids_seen] = patient_ids_seen | [resource.id] if @resource_type == 'Patient'

        unless resource_is_valid?(resource:)
          if first_error.key?(:line_number)
            @invalid_resource_count_all += 1
            @invalid_resource_count += 1
          else
            @invalid_resource_count_all.zero? ? @invalid_resource_count_all = 1 : @invalid_resource_count_all += 1

            @invalid_resource_count = 1
            first_error[:line_number] = line_count
            first_error[:messages] = messages.dup
          end
        end
      end

      process_headers = proc { |response|
        value = (response[:headers].find { |header| header.name.downcase == 'content-type' })&.value
        unless value&.start_with?('application/fhir+ndjson')
          skip "Content type must have 'application/fhir+ndjson' but found '#{value}'"
        end
      }

      stream_ndjson(url, build_headers(bulk_requires_access_token), process_line, process_headers)
      resources_from_all_files.merge!(resources) do |_key, all_resources, file_resources|
        all_resources | file_resources
      end
      line_count
    end

    def process_validation_errors(resource_count)
      return if @invalid_resource_count.nil? || @invalid_resource_count.zero?

      first_error_message = "The line number for the first failed #{@resource_type} resource is #{first_error[:line_number]}."

      messages.clear
      messages.concat(first_error[:messages])

      error_message = "#{@invalid_resource_count} / #{resource_count} #{@resource_type} resources failed profile validation. " \
              "#{first_error_message}"

      validation_errors.append(error_message)
    end

    def perform_bulk_export_validation(bulk_status_output: '', bulk_requires_access_token: '')
      skip_if bulk_status_output.blank?, 'Could not verify this functionality when Bulk Status Output is not provided'
      skip_if (bulk_requires_access_token == 'true' && smart_auth_info.access_token.blank?),
              'Could not verify this functionality when Bearer Token is required and not provided'

      $num_messages = 0
      $capped_message = false
      $num_errors = 0
      $capped_errors = false

      assert_valid_json(bulk_status_output)

      full_file_list = JSON.parse(bulk_status_output)
      if full_file_list.empty?
        message = 'No resource file items returned by server.'
        skip message
      end

      @resources_from_all_files = {}

      resource_types = full_file_list.map { |file| file['type'] }.uniq
      all_resource_count = 0
      @invalid_resource_count_all = 0
      @validation_errors = []

      resource_types.each do |type|
        @resource_type = type
        @first_error = {}
        @invalid_resource_count = 0
        resource_count = 0

        file_list = full_file_list.select { |file| file['type'] == @resource_type }

        file_list.each do |file|
          count = check_file_request(file['url'], bulk_requires_access_token)
          all_resource_count += count
          resource_count += count
        end

        process_validation_errors(resource_count)
      end

      assert @invalid_resource_count_all.zero?,
             "#{@invalid_resource_count_all} / #{all_resource_count} Resources failed validation. \n" + @validation_errors.join("\n")

      pass "Successfully validated #{all_resource_count} Resources"
    end

    def ndjson_download_requiresAccessToken_check(bulk_data_download_url: '', bulk_requires_access_token: '')
      skip_if bulk_data_download_url.blank?, 'Could not verify this functionality when no download link was provided'
      skip_if bulk_requires_access_token.blank?,
              'Could not verify this functionality when requiresAccessToken is not provided'
      omit_if bulk_requires_access_token == 'false',
              'Could not verify this functionality when requiresAccessToken is false'
      skip_if smart_auth_info.access_token.blank?,
              'Could not verify this functionality when Bearer Token is not provided'

      get(bulk_data_download_url, headers: { accept: 'application/fhir+ndjson' })
      assert_response_status([400, 401])
    end

    def export_multiple_patients_check
      skip 'No Patient resources processed from bulk data export.' unless patient_ids_seen.present?

      begin
        assert patient_ids_seen.length >= BulkExportValidationTester::MIN_RESOURCE_COUNT,
               'Bulk data export did not have multiple Patient resources.'
      ensure
        scratch[:patient_ids_seen] = []
      end
    end
  end
end
