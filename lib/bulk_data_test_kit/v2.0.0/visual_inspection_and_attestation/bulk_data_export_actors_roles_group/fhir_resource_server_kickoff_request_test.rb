# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class FhirResourceServerKickoffRequestAttestationTest < Inferno::Test
      title 'Accepts kick-off request'
      id :bulkdata_resource_server_kickoff_request
      description %(
        The FHIR Resource Server accepts kick-off requests.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@20'

      input :resource_server_kickoff_request_correct,
            title: 'Bulk Data Export Actors and Roles: Accepts kick-off request',
            description: %(
              I attest that the FHIR Resource Server accepts kick-off requests.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :resource_server_kickoff_request_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert resource_server_kickoff_request_correct == 'true',
               'FHIR Resource Server does not accept kick-off requests.'
        pass resource_server_kickoff_request_note if resource_server_kickoff_request_note.present?
      end
    end
  end
end
