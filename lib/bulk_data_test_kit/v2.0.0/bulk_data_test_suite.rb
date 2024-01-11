require 'smart_app_launch/smart_stu1_suite'
require 'smart_app_launch/smart_stu2_suite'
require_relative '../version'
require_relative 'bulk_data_group_export_test_group'
require_relative 'bulk_data_patient_export_test_group'

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

        exclude_message do |message|
          message_filters.any? { |filter| filter.match? message.message }
        end
      end

      def self.jwks_json
        bulk_data_jwks = JSON.parse(File.read(
                                      ENV.fetch('BULK_DATA_JWKS',
                                                File.join(__dir__, 'bulk_data_test_kit',
                                                          'bulk_data_jwks.json'))
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

        * `#{Inferno::Application[:base_url]}/custom/g10_certification/.well-known/jwks.json`

        Systems must pass all tests in order to qualify for ONC certification.
      )

      input_instructions %(
        Register Inferno as a bulk data client with the following information, and
        enter the client id and client registration in the appropriate fields.
        This set of tests only checks the Group export. Enter the group export
        information in the appropriate box.

        Register Inferno with the following JWK Set Url:

        * `#{Inferno::Application[:base_url]}/custom/bulk_data_v101/.well-known/jwks.json`
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

      group do
        id :bulk_data_server_tests_stu2
        title 'Bulk Data Server TLS Tests'
        run_as_group
        
        test from: :tls_version_test do
          title 'Bulk Data Server is secured by transport layer security'
          description <<~DESCRIPTION
            [§170.315(g)(10) Test
            Procedure](https://www.healthit.gov/test-method/standardized-api-patient-and-population-services)
            requires that all exchanges described herein between a client and a
            server SHALL be secured using Transport Layer Security (TLS) Protocol
            Version 1.2 (RFC5246).
          DESCRIPTION
          id :bulk_data_server_tls_version_stu2

          config(
            inputs: { url: { name: :bulk_server_url } },
            options: { minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION }
          )
        end
      end
      
      group from: :bulk_data_group_export_v200
      group from: :bulk_data_patient_export_v200
    end
  end
end