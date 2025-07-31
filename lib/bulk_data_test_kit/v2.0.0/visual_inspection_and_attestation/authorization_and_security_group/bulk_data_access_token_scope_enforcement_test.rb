# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataAccessTokenScopeEnforcementAttestationTest < Inferno::Test
      title 'Validates access token and scope'
      id :bulkdata_access_token_scope_enforcement
      description %(
        The resource server validates the access token, ensures it has not expired, and ensures its scope
        covers the requested resource.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@265',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@266'

      input :access_token_scope_enforcement_correct,
            title: 'Authorization, Authentication, and Security: Validates access token and scope',
            description: %(
              I attest that the resource server validates the access token, ensures it has not expired, and ensures
              its scope covers the requested resource.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :access_token_scope_enforcement_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert access_token_scope_enforcement_correct == 'true',
               'Resource server does not validate access token and scope as required.'
        pass access_token_scope_enforcement_note if access_token_scope_enforcement_note.present?
      end
    end
  end
end
