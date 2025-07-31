# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientGeneratesOneTimeJwtAttestationTest < Inferno::Test
      title 'Generates a one-time-use authentication JWT before requesting an access token'
      id :client_generates_one_time_jwt
      description %(
        Before requesting an access token, the client generates a one-time-use authentication JWT as described
        in client-confidential-asymmetric authentication.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@233',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@319'

      input :client_generates_one_time_jwt_correct,
            title: %(
             Client Authentication & Token Request: Generates a one-time-use authentication JWT before
             requesting an access token'
            ),
            description: %(
              I attest that before requesting an access token, the client generates a one-time-use authentication
              JWT as described in client-confidential-asymmetric authentication.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_generates_one_time_jwt_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_generates_one_time_jwt_correct == 'true',
               'Client does not generate a one-time-use authentication JWT before requesting an access token.'
        pass client_generates_one_time_jwt_note if client_generates_one_time_jwt_note.present?
      end
    end
  end
end
