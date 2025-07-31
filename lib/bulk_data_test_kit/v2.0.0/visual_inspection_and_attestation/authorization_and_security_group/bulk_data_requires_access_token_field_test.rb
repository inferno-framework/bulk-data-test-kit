# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataRequiresAccessTokenFieldAttestationTest < Inferno::Test
      title 'Sets requiresAccessToken field in manifest appropriately'
      id :bulkdata_requires_access_token_field
      description %(
        The requiresAccessToken field in the manifest is set to true if both the file server and the FHIR API server
        control access using OAuth 2.0 bearer tokens.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@162'

      input :requires_access_token_field_correct,
            title: %(
              Authorization, Authentication, and Security: Sets requiresAccessToken field in manifest appropriately
            ),
            description: %(
              I attest that the requiresAccessToken field in the manifest is set to true if both the file server
              and the FHIR API server control access using OAuth 2.0 bearer tokens.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :requires_access_token_field_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert requires_access_token_field_correct == 'true',
               'requiresAccessToken field in manifest is not set appropriately.'
        pass requires_access_token_field_note if requires_access_token_field_note.present?
      end
    end
  end
end
