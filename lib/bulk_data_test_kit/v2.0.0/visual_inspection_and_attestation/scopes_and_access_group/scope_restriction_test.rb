# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class ScopeRestrictionAttestationTest < Inferno::Test
      title 'Applies SMART Scopes syntax as additional access restrictions'
      id :smart_scope_restriction
      description %(
        The server applies the scopes included in the access token request as additional access restrictions, following
        the SMART Scopes syntax.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@241'

      input :scope_restriction_correct,
            title: 'Scopes and Access: Applies SMART Scopes syntax as additional access restrictions',
            description: %(
              I attest that the server applies the scopes included in the access token request as additional access
              restrictions, following the SMART Scopes syntax.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :scope_restriction_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert scope_restriction_correct == 'true',
               'The server does not apply SMART Scopes syntax as additional access restrictions.'
        pass scope_restriction_note if scope_restriction_note.present?
      end
    end
  end
end
