# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientJwsSupportAttestationTest < Inferno::Test
      title 'Capable of generating a JSON Web Signature per RFC7515'
      id :client_jws_support
      description %(
        The client SHALL be capable of generating a JSON Web Signature in accordance with
        [RFC7515](https://tools.ietf.org/html/rfc7515).
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@307'

      input :client_jws_support_correct,
            title: 'Client Key Management & JWK Registration: Capable of generating a JSON Web Signature per RFC7515',
            description: %(
              I attest that the client is capable of generating a JSON Web Signature in accordance with
              [RFC7515](https://tools.ietf.org/html/rfc7515).
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_jws_support_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_jws_support_correct == 'true',
               'Client is not capable of generating a JSON Web Signature per RFC7515.'
        pass client_jws_support_note if client_jws_support_note.present?
      end
    end
  end
end
