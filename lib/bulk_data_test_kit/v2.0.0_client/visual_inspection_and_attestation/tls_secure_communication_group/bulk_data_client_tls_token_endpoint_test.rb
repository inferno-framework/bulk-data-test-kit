# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class BulkDataClientTlsTokenEndpointAttestationTest < Inferno::Test
      title 'Uses TLS 1.2 or newer to secure token endpoint exchanges'
      id :bulkdata_client_tls_token_endpoint
      description %(
       The client uses TLS 1.2 or a more recent version of TLS to authenticate the identity of the FHIR authorization
       server and to establish an encrypted, integrity-protected link for securing all exchanges between the client
       and the FHIR authorization server’s token endpoint.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@230',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@318'

      input :client_tls_token_endpoint_correct,
            title: 'TLS and Secure Communication: Uses TLS 1.2 or newer to secure token endpoint exchanges',
            description: %(
              I attest that the client uses TLS 1.2 or a more recent version of TLS to authenticate the identity of
              the FHIR authorization server and to establish an encrypted, integrity-protected link for securing all
              exchanges between the client and the FHIR authorization server’s token endpoint.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_tls_token_endpoint_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_tls_token_endpoint_correct == 'true',
               'Client does not use TLS 1.2 or newer to secure token endpoint exchanges.'
        pass client_tls_token_endpoint_note if client_tls_token_endpoint_note.present?
      end
    end
  end
end
