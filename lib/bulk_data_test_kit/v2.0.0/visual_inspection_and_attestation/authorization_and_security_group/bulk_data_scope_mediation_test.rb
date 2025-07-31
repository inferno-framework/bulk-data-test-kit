# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class ScopeMediationAttestationTest < Inferno::Test
      title 'Mediates requested scope'
      id :bulkdata_scope_mediation
      description %(
        After client authentication, the FHIR authorization server mediates the request to ensure that the scope
        requested is within the scope pre-authorized to the client.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@250'

      input :scope_mediation_supported,
            title: 'Authorization, Authentication, and Security: Mediates requested scope',
            description: %(
              I attest that, after client authentication, the FHIR authorization server mediates the request to ensure
              the requested scope is within the scope pre-authorized to the client.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :scope_mediation_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert scope_mediation_supported == 'true',
               'Authorization server does not mediate requested scope as required.'
        pass scope_mediation_note if scope_mediation_note.present?
      end
    end
  end
end
