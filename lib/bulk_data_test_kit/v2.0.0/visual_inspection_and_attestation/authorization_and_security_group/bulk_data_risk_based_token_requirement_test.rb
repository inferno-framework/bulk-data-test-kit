# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataRiskBasedTokenRequirementAttestationTest < Inferno::Test
      title 'Enforces resource server risk-based rules to obtain and present an access token'
      id :bulkdata_risk_based_token_requirement
      description %(
        Rules regarding circumstances under which a client is required to obtain and present an access token along
        with a request are based on risk-management decisions that each FHIR resource service needs to make,
        considering the workflows involved, perceived risks, and the organization’s risk-management policies.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@247'

      input :risk_based_token_requirement_correct,
            title: %(
              Authorization, Authentication, and Security: Enforces resource server risk-based rules to obtain and
              present an access token
            ),
            description: %(
              I attest that rules regarding circumstances under which a client is required to obtain and present an
              access token along with a request are based on risk-management decisions that each FHIR resource service
              needs to make, considering the workflows involved, perceived risks, and the organization’s
              risk-management policies.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :risk_based_token_requirement_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert risk_based_token_requirement_correct == 'true',
               'Resource server does not enforce access token requirements based on risk-management decisions.'
        pass risk_based_token_requirement_note if risk_based_token_requirement_note.present?
      end
    end
  end
end
