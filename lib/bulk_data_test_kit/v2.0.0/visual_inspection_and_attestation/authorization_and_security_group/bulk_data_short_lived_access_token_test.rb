# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataShortLivedAccessTokenAttestationTest < Inferno::Test
      title 'Ensures access tokens issued are short-lived'
      id :bulkdata_short_lived_access_token
      description %(
        Access tokens issued under the backend services profile are short-lived.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@261'

      input :short_lived_access_token_correct,
            title: 'Authorization, Authentication, and Security: Ensures access tokens issued are short-lived',
            description: %(
              I attest that access tokens issued under the backend services profile are short-lived.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :short_lived_access_token_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert short_lived_access_token_correct == 'true',
               'Access tokens issued are not short-lived.'
        pass short_lived_access_token_note if short_lived_access_token_note.present?
      end
    end
  end
end
