# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataPartialSuccessAttestationTest < Inferno::Test
      title 'Populates Response.error array and uses 200 status for partial success'
      id :bulkdata_partial_success
      description %(
        If the overall export succeeds but some resources fail to export, the Bulk Data server populates the
        Response.error array with one or more files in ndjson format containing FHIR OperationOutcome resources,
        and uses a 200 status code instead of 4XX or 5XX.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@142',
                            'hl7.fhir.uv.bulkdata_2.0.0@143'

      input :partial_success_correct,
            title: %(
              Bulk Data Export Response Handling: Populates Response.error array and uses 200 status for partial
              success
            ),
            description: %(
              I attest that if the overall export succeeds but some resources fail to export, the Bulk Data server
              populates the Response.error array with one or more files in ndjson format containing FHIR
              OperationOutcome resources, and uses a 200 status code instead of 4XX or 5XX.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :partial_success_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert partial_success_correct == 'true',
               'Bulk Data server does not properly handle partial success cases.'
        pass partial_success_note if partial_success_note.present?
      end
    end
  end
end
