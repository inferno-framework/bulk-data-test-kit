# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class FhirResourceServerJobStatusAttestationTest < Inferno::Test
      title 'Provides job status'
      id :bulkdata_resource_server_job_status
      description %(
        The FHIR Resource Server provides job status.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@21'

      input :resource_server_job_status_correct,
            title: 'Bulk Data Export Actors and Roles: Provides job status',
            description: %(
              I attest that the FHIR Resource Server provides job status.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :resource_server_job_status_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert resource_server_job_status_correct == 'true',
               'FHIR Resource Server does not provide job status.'
        pass resource_server_job_status_note if resource_server_job_status_note.present?
      end
    end
  end
end
