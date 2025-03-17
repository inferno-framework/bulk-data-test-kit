# frozen_string_literal: true

require_relative '../version'
require_relative 'bulk_data_smart_backend_services_v101_group'
require_relative 'bulk_data_export_tests_test_group'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataTestSuite < Inferno::TestSuite
      title 'Bulk Data Access v1.0.1 Server'
      id :bulk_data_v101
      links [
        {
          label: 'Report Issue',
          url: 'https://github.com/inferno-framework/bulk-data-test-kit/issues/'
        },
        {
          label: 'Open Source',
          url: 'https://github.com/inferno-framework/bulk-data-test-kit/'
        },
        {
          label: 'Download',
          url: 'https://github.com/inferno-framework/bulk-data-test-kit/releases'
        }
      ]

      VALIDATION_MESSAGE_FILTERS = [
        /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
        /\A\S+: \S+: URL value '.*' does not resolve/
      ].freeze

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      fhir_resource_validator do
        message_filters = VALIDATION_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

        $num_messages = 0
        $capped_message = false
        $num_errors = 0
        $capped_errors = false

        exclude_message do |message|
          matches_filter = message_filters.any? { |filter| filter.match? message.message }

          unless matches_filter
            if message.type != 'error'
              $num_messages += 1
            else
              $num_errors += 1
            end
          end

          matches_filter ||
            (message.type != 'error' && $num_messages > 50 && !message.message.include?('Inferno is only showing the first')) ||
            (message.type == 'error' && $num_errors > 20 && !message.message.include?('Inferno is only showing the first'))
        end

        perform_additional_validation do
          if $num_messages > 50 && !$capped_message
            $capped_message = true
            { type: 'info', message: 'Inferno is only showing the first 50 validation info and warning messages.' }
          elsif $num_errors > 20 && !$capped_errors
            $capped_errors = true
            { type: 'error', message: 'Inferno is only showing the first 20 validation error messages.' }
          end
        end
      end

      def self.jwks_json
        bulk_data_jwks = JSON.parse(File.read(
                                      ENV.fetch('BULK_DATA_JWKS',
                                                File.join(File.expand_path('..', __dir__), 'bulk_data_jwks.json'))
                                    ))
        @jwks_json ||= JSON.pretty_generate(
          { keys: bulk_data_jwks['keys'].select { |key| key['key_ops']&.include?('verify') } }
        )
      end

      def self.well_known_route_handler
        ->(_env) { [200, { 'Content-Type' => 'application/json' }, [jwks_json]] }
      end

      route(
        :get,
        '/.well-known/jwks.json',
        well_known_route_handler
      )

      config(
        options: {
          post_authorization_uri: "#{Inferno::Application['base_url']}/custom/smart_stu2/post_auth"
        }
      )

      description %(

        The Bulk Data Access v1.0.1 suite validates the conformance of a FHIR®
        server to the [FHIR Bulk Data Access
        IG STU1.0.1](http://hl7.org/fhir/uv/bulkdata/STU1.0.1).

        This test suite is split into three different types of bulk data export:

        - All Patients: FHIR Operation to obtain a detailed set of FHIR
          resources of diverse resource types pertaining to all patients
        - Group of Patients: FHIR Operation to obtain a detailed set of FHIR
          resources of diverse resource types pertaining to all members of a
          specified Group 
        - System Level Export: FHIR Operation to export data from a FHIR
          server, whether or not it is associated with a patient

        This test suite uses [Backend Services
        Authorization](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/authorization/index.html)
        to obtain an access token from the server. After authorization, a group
        level, patient level, and system level bulk data export request is
        initialized, and for each type of export, the tests read exported NDJSON
        files from the server and validate the resources in each file against
        the base FHIR specification.

        To get started, if your server supports SMART backend services
        authorization, please first register Inferno with the following JWK Set
        URL:

        * `#{Inferno::Application[:base_url]}/custom/bulk_data_v101/.well-known/jwks.json`

        Then, run the full Bulk Data Access test suite containing both the SMART
        Backend Services test group and the Bulk Data Export Tests test group.
        Otherwise, if your server does not support SMART Backend Services
        authorization, only run the second test group, Bulk Data Export Tests.
      )

      input_instructions %(
        Register Inferno as a bulk data client with the following information,
        and enter the client id and client registration in the appropriate
        fields. For the Group export tests, please enter the group export
        information in the appropriate box.

        Register Inferno with the following JWK Set Url:

        * `#{Inferno::Application[:base_url]}/custom/bulk_data_v101/.well-known/jwks.json`
      )

      input :bulk_server_url,
            title: 'Bulk Data FHIR URL',
            description: 'The URL of the Bulk FHIR server.'

      fhir_client :bulk_server do
        url :bulk_server_url
        auth_info :smart_auth_info
      end

      http_client :bulk_server do
        url :bulk_server_url
        auth_info :smart_auth_info
      end

      group from: :bulk_data_smart_backend_services_v101

      group from: :bulk_data_export_tests_v101,
            config: {
              inputs: {
                bulk_auth_info: { name: :smart_auth_info }
              }
            }
    end
  end
end
