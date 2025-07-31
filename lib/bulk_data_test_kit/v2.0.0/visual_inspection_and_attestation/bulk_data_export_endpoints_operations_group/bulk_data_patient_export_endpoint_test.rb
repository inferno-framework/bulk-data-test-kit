# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientExportEndpointAttestationTest < Inferno::Test
      title 'Supports Bulk Data Patient Level Export endpoint'
      id :bulkdata_patient_export_endpoint
      description %(
        If the server supports Bulk Data Patient Export, the endpoint is `[fhir base]/Patient/$export`.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@273',
                            'hl7.fhir.uv.bulkdata_2.0.0@297'

      input :patient_export_endpoint_correct,
            title: 'Bulk Data Export Endpoints and Operations: Supports Bulk Data Patient Level Export endpoint',
            description: %(
              I attest that if the server supports Bulk Data Patient Export, the endpoint is
              `[fhir base]/Patient/$export`.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :patient_export_endpoint_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert patient_export_endpoint_correct == 'true',
               'Bulk Data Patient Level Export endpoint is not supported as required.'
        pass patient_export_endpoint_note if patient_export_endpoint_note.present?
      end
    end
  end
end
