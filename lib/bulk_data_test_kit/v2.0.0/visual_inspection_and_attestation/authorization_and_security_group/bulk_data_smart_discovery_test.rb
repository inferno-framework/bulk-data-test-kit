# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSmartDiscoveryAttestationTest < Inferno::Test
      title 'Advertises required properties in SMART configuration endpoint'
      id :bulkdata_smart_discovery
      description %(
        The server advertises support for SMART Confidential Clients with Asymmetric Keys at its
        .well-known/smart-configuration endpoint, including required properties: token_endpoint,
        scopes_supported, token_endpoint_auth_methods_supported (with private_key_jwt),
        token_endpoint_auth_signing_alg_values_supported (with at least RS384 or ES384), and grant_types_supported.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@228',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@285',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@286',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@287',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@288',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@289',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@384'

      input :smart_discovery_correct,
            title: %(
              Authorization, Authentication, and Security: Advertises required properties in SMART configuration
              endpoint
            ),
            description: %(
              I attest that the server advertises support for SMART Confidential Clients with Asymmetric Keys at its
              .well-known/smart-configuration endpoint, including required properties: token_endpoint,
              scopes_supported, token_endpoint_auth_methods_supported (with private_key_jwt),
              token_endpoint_auth_signing_alg_values_supported (with at least RS384 or ES384), and
              grant_types_supported.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :smart_discovery_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert smart_discovery_correct == 'true',
               'SMART configuration endpoint does not advertise required properties.'
        pass smart_discovery_note if smart_discovery_note.present?
      end
    end
  end
end
