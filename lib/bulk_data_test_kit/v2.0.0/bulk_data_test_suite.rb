require_relative '../version'
require_relative '../v1.0.1/bulk_data_smart_backend_services_group'
require_relative 'bulk_data_export_tests_test_group'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataTestSuite < Inferno::TestSuite
      title 'Bulk Data Access v2.0.0'
      version VERSION
      id :bulk_data_v200
      links [
        {
          label: 'Report Issue',
          url: 'https://github.com/onc-healthit/bulk_data_test_kit/issues/'
        },
        {
          label: 'Open Source',
          url: 'https://github.com/onc-healthit/bulk_data_test_kit/'
        },
        {
          label: 'Download',
          url: 'https://github.com/onc-healthit/bulk_data_test_kit/releases'
        }
      ]

      VALIDATION_MESSAGE_FILTERS = [
        /Observation\.effective\.ofType\(Period\): .*vs-1:/ # Invalid invariant in FHIR v4.0.1
      ].freeze

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      validator do
        url ENV.fetch('BULK_DATA_VALIDATOR_URL', 'http://validator_service:4567')

        message_filters = VALIDATION_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

        $num_messages = 0
        $capped_message = false
        $num_errors = 0
        $capped_errors = false

        
        exclude_message do |message|
          if message.type != 'error'
            $num_messages+=1 
          else
            $num_errors+=1 
          end

          message_filters.any? { |filter| filter.match? message.message } ||
          (message.type != 'error' && $num_messages > 50 && !message.message.include?('Inferno is only showing the first')) ||
          (message.type == 'error' && $num_errors > 20 && !message.message.include?('Inferno is only showing the first'))
        end

        perform_additional_validation do
          if $num_messages > 50 && !$capped_message
            $capped_message = true
            { type: 'info', message: 'Inferno is only showing the first 50 validation info and warning messages.'}
          elsif $num_errors > 20 && !$capped_errors
            $capped_errors = true
            { type: 'error', message: 'Inferno is only showing the first 20 validation error messages.'}
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
        inputs: {
          client_auth_encryption_method: {
            title: 'Client Authentication Encryption Method',
            locked: true
          }
        },
        options: {
          post_authorization_uri: "#{Inferno::Application['base_url']}/custom/smart_stu2/post_auth"
        }
      )

      description %(
        The Bulk Data Access Test Kit is a testing tool that will demonstrate the ability to export clinical data for multiple patients. This test kit is split into
        two different types of bulk patient export: the export of patients in a specified group and the export of all patients, using [FHIR Bulk Data Access
        IG](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/). This test kit uses [Backend Services
        Authorization](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/authorization/index.html)
        to obtain an access token from the server. After authorization, a group
        level bulk data export request and a patient level bulk data export request (to request all patients) 
        are initialized. Finally, the tests readexported NDJSON files from the server and validate the resources in
        each file. To run these tests successfully, the selected group or patient export is
        required to have every type of resource mapped to [USCDI data
        elements](https://www.healthit.gov/isa/us-core-data-interoperability-uscdi).
        Additionally, it is expected the server will provide Encounter,
        Location, Organization, and Practitioner resources as they are
        referenced as must support elements in required resources.

        To get started, please first register Inferno with the following JWK Set
        Url:

        * `#{Inferno::Application[:base_url]}/custom/bulk_data_v200/.well-known/jwks.json`

        Systems must pass all tests in order to qualify for ONC certification.
      )

      input_instructions %(
        Register Inferno as a bulk data client with the following information, and
        enter the client id and client registration in the appropriate fields.
        This set of tests only checks the Group export. Enter the group export
        information in the appropriate box.

        Register Inferno with the following JWK Set Url:

        * `#{Inferno::Application[:base_url]}/custom/bulk_data_v200/.well-known/jwks.json`
      )

      input :bulk_server_url,
        title: 'Bulk Data FHIR URL',
        description: 'The URL of the Bulk FHIR server.'

      fhir_client :bulk_server do
        url :bulk_server_url
      end

      http_client :bulk_server do
        url :bulk_server_url
      end

      group from: :bulk_data_smart_backend_services,
        id: :bulk_data_smart_backend_services_v200

      group from: :bulk_data_export_tests_v200

    end
  end
end