# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ConfidentialClientRequirementAttestationTest < Inferno::Test
      title 'Ensures it is a confidential client capable of protecting its authentication credential'
      id :confidential_client_requirement
      description %(
        Client is a confidential client capable of protecting its authentication credential, as required
        for use of the client credentials grant type.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@229'

      input :confidential_client_requirement_correct,
            title: %(
              Bulk Data Client Role and Data Retrieval: Ensures it is a confidential client capable of protecting its
              authentication credential
            ),
            description: %(
              I attest that the client is a confidential client capable of protecting its authentication credential,
              as required for use of the client credentials grant type.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :confidential_client_requirement_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert confidential_client_requirement_correct == 'true',
               'Client is not a confidential client capable of protecting its authentication credential as required.'
        pass confidential_client_requirement_note if confidential_client_requirement_note.present?
      end
    end
  end
end
