# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientJwkSetUrlTlsAttestationTest < Inferno::Test
      title 'Ensures Client JWK Set URL is a TLS-protected endpoint'
      id :client_jwk_set_url_tls
      description %(
        For the URL to JWK Set method, the value is the TLS-protected endpoint where the client’s public JWK Set can be
        found.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@301'

      input :client_jwk_set_url_tls_correct,
            title: 'Client Key Management & JWK Registration: Ensures Client JWK Set URL is a TLS-protected endpoint',
            description: %(
              I attest that for the URL to JWK Set method, the value is the TLS-protected endpoint where the client’s
              public JWK Set can be found.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_jwk_set_url_tls_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_jwk_set_url_tls_correct == 'true',
               'Client JWK Set URL is not a TLS-protected endpoint as required.'
        pass client_jwk_set_url_tls_note if client_jwk_set_url_tls_note.present?
      end
    end
  end
end
