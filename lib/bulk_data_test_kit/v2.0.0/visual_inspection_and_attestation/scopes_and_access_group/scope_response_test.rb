# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class ScopeResponseAttestationTest < Inferno::Test
      title 'Allows for scope in access token response to differ from requested scopes'
      id :smart_scope_response
      description %(
        The scope parameter value in the access token response can be different from the scopes requested by the app,
        as allowed by the specification.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@259'

      input :scope_response_correct,
            title: 'Scopes and Access: Allows for scope in access token response to differ from requested scopes',
            description: %(
              I attest that the scope parameter value in the access token response can be different from the scopes
              requested by the app, as allowed by the specification.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :scope_response_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert scope_response_correct == 'true',
               'The scope parameter value in the access token response cannot differ from the scopes requested
                by the app.'
        pass scope_response_note if scope_response_note.present?
      end
    end
  end
end
