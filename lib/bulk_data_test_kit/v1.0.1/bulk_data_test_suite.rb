require 'smart_app_launch/smart_stu1_suite'
require 'smart_app_launch/smart_stu2_suite'
require_relative '../version'
require_relative 'bulk_data_group_export_group'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataTestSuite < Inferno::TestSuite
      title 'Bulk Data Access v1.0.1'
      version VERSION
      id :bulk_data_v101
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

      validator do
        url ENV.fetch('BULK_DATA_VALIDATOR_URL', 'http://validator_service:4567')
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
        The Bulk Data Access Test Kit is a testing tool that will demonstrate the ability to export clinical data for multiple patients in
        a group using [FHIR Bulk Data Access
        IG](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/). This test kit uses [Backend Services
        Authorization](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/authorization/index.html)
        to obtain an access token from the server. After authorization, a group
        level bulk data export request is initialized. Finally, the tests read
        exported NDJSON files from the server and validate the resources in
        each file. To run these tests successfully, the selected group export is
        required to have every type of resource mapped to [USCDI data
        elements](https://www.healthit.gov/isa/us-core-data-interoperability-uscdi).
        Additionally, it is expected the server will provide Encounter,
        Location, Organization, and Practitioner resources as they are
        referenced as must support elements in required resources.

        To get started, please first register the Inferno client as a SMART App
        with the following information:

        * SMART Launch URI: `#{SMARTAppLaunch::AppLaunchTest.config.options[:launch_uri]}`
        * OAuth Redirect URI: `#{SMARTAppLaunch::AppRedirectTest.config.options[:redirect_uri]}`

        For the multi-patient API, register Inferno with the following JWK Set
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

      group do
        title 'Bulk Data API Tests'
        description %(
          The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server) 
          to support required Bulk Data $export operation.                  
        )
        input_order :bulk_server_url,
                    :bearer_token,
                    :group_id,
                    :bulk_timeout

        group from: :bulk_data_group_export_group
      end
    end
  end
end