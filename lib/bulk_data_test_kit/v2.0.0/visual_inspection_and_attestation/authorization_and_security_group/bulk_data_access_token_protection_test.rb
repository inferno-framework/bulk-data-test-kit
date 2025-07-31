# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataAccessTokenProtectionAttestationTest < Inferno::Test
      title 'Protects requiring access token with proper scopes'
      id :bulkdata_access_token_protection
      description %(
        When SMART Backend Services Authorization is used, Bulk Data Status Request and Output File Requests with
        requiresAccessToken=true are protected the same way as the Bulk Data Kick-off Request, including an access
        token with scopes that cover all resources being exported.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@5'

      input :access_token_protection_correct,
            title: 'Authorization, Authentication, and Security: Protects requiring access token with proper scopes',
            description: %(
              I attest that when SMART Backend Services Authorization is used, Bulk Data Status Request and Output
              File Requests with requiresAccessToken=true are protected the same way as the Bulk Data Kick-off
              Request, including an access token with scopes that cover all resources being exported.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :access_token_protection_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert access_token_protection_correct == 'true',
               'Bulk Data endpoints requiring access token are not protected with proper scopes.'
        pass access_token_protection_note if access_token_protection_note.present?
      end
    end
  end
end
