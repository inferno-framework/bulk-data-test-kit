# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientTokenRequestParametersAttestationTest < Inferno::Test
      title 'Client includes required parameters in access token request'
      id :client_token_request_parameters
      description %(
        When requesting an access token via HTTP POST to the FHIR authorization server’s token endpoint URL,
        the client includes the following required parameters:
        - `scope`: required, contains the scope of access requested, following the SMART Scopes syntax.
        - `grant_type`: required, fixed value: client_credentials.
        - `client_assertion_type`: required, fixed value: urn:ietf:params:oauth:client-assertion-type:jwt-bearer.
        - `client_assertion`: required, contains the signed authentication JWT value.
        - Uses the assigned client_id.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@235',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@236',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@237',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@238',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@317',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@333',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@334'

      input :client_token_request_parameters_correct,
            title: 'Client Authentication & Token Request: Client includes required parameters in access token request',
            description: %(
              I attest that when requesting an access token via HTTP POST to the FHIR authorization server’s token
              endpoint URL, the client includes the following required parameters:
              - `scope`: required, contains the scope of access requested, following the SMART Scopes syntax.
              - `grant_type`: required, fixed value: client_credentials.
              - `client_assertion_type`: required, fixed value: urn:ietf:params:oauth:client-assertion-type:jwt-bearer.
              - `client_assertion`: required, contains the signed authentication JWT value.
              - Uses the assigned client_id.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_token_request_parameters_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_token_request_parameters_correct == 'true',
               'Client does not include all required parameters in access token request.'
        pass client_token_request_parameters_note if client_token_request_parameters_note.present?
      end
    end
  end
end
