# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportEndpointAttestationTest < Inferno::Test
      title 'Supports Bulk Data Group Level Export endpoint'
      id :bulkdata_group_export_endpoint
      description %(
        If the server supports Bulk Data Group Export, the endpoint is `[fhir base]/Group/[id]/$export`.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@250',
                            'hl7.fhir.uv.bulkdata_2.0.0@298'

      input :group_export_endpoint_correct,
            title: 'Bulk Data Export Endpoints and Operations: Supports Bulk Data Group Level Export endpoint',
            description: %(
              I attest that if the server supports Bulk Data Group Export, the endpoint is
              `[fhir base]/Group/[id]/$export`.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :group_export_endpoint_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert group_export_endpoint_correct == 'true',
               'Bulk Data Group Level Export endpoint is not supported as required.'
        pass group_export_endpoint_note if group_export_endpoint_note.present?
      end
    end
  end
end
