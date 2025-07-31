# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class InvalidClientErrorAttestationTest < Inferno::Test
      title 'Responds with invalid_client error on authentication failure'
      id :bulk_data_invalid_client_error
      description %(
        If an error is encountered during the authentication process, the server responds with an
        `invalid_client error` as defined by the [OAuth 2.0 specification](https://tools.ietf.org/html/rfc6749#section-5.2).
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@340'

      input :invalid_client_error_supported,
            title: %(
             Authorization, Authentication, and Security: Responds with invalid_client error on authentication failure
            ),
            description: %(
              I attest that if an error is encountered during the authentication process, the server responds with
              an `invalid_client error` as defined by the [OAuth 2.0 specification](https://tools.ietf.org/html/rfc6749#section-5.2).
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :invalid_client_error_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert invalid_client_error_supported == 'true',
               'Server does not respond with invalid_client error on authentication failure as required.'
        pass invalid_client_error_note if invalid_client_error_note.present?
      end
    end
  end
end
