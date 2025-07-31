# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientRequestsAccessTokenViaPostAttestationTest < Inferno::Test
      title 'Requests access token via HTTP POST to token endpoint'
      id :client_requests_access_token_via_post
      description %(
        After generating the authentication JWT, the client requests an access token via HTTP POST to the FHIR
        authorization server’s token endpoint URL, using content-type application/x-www-form-urlencoded.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@234'

      input :client_requests_access_token_via_post_correct,
            title: 'Client Authentication & Token Request: Requests access token via HTTP POST to token endpoint',
            description: %(
              I attest that after generating the authentication JWT, the client requests an access token via HTTP POST
              to the FHIR authorization server’s token endpoint URL, using content-type
              application/x-www-form-urlencoded.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_requests_access_token_via_post_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_requests_access_token_via_post_correct == 'true',
               'Client does not request access token via HTTP POST to token endpoint as required.'
        pass client_requests_access_token_via_post_note if client_requests_access_token_via_post_note.present?
      end
    end
  end
end
