require 'smart_app_launch/smart_stu1_suite'
require 'smart_app_launch/smart_stu2_suite'

require_relative '../version'
require_relative 'multi_patient_api'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataTestSuite < Inferno::TestSuite
      title 'FHIR Bulk Data API Test Kit V1.0.1'
      short_title 'Bulk Data API'
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
          post_authorization_uri: "#{Inferno::Application['base_url']}/custom/smart_stu2/post_auth",
          incorrectly_permitted_tls_version_message_type: 'warning'
        }
      )

      description %(
        The ONC Certification (g)(10) Standardized API Test Kit is a testing tool for
        Health Level 7 (HL7®) Fast Healthcare Interoperability Resources (FHIR®)
        services seeking to meet the requirements of the Standardized API for
        Patient and Population Services criterion § 170.315(g)(10) in the 2015
        Edition Cures Update.

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
          Register Inferno as a SMART app using the following information:

          * Launch URI: `#{SMARTAppLaunch::AppLaunchTest.config.options[:launch_uri]}`
          * Redirect URI: `#{SMARTAppLaunch::AppRedirectTest.config.options[:redirect_uri]}`

          For the multi-patient API, register Inferno with the following JWK Set
          Url:

          * `#{Inferno::Application[:base_url]}/custom/g10_certification/.well-known/jwks.json`
        )

      group from: :multi_patient_api
    end
  end
end