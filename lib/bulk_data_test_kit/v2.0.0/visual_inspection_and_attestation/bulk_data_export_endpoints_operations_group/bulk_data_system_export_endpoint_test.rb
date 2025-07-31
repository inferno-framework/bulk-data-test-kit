# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemExportEndpointAttestationTest < Inferno::Test
      title 'Supports Bulk Data System Level Export endpoint'
      id :bulkdata_system_export_endpoint
      description %(
        If the server supports Bulk Data System Level Export, the endpoint is `[fhir base]/$export`.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@299'

      input :system_export_endpoint_correct,
            title: 'Bulk Data Export Endpoints and Operations: Supports Bulk Data System Level Export endpoint',
            description: %(
              I attest that if the server supports Bulk Data System Level Export, the endpoint is
              [fhir base]/$export`.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :system_export_endpoint_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert system_export_endpoint_correct == 'true',
               'Bulk Data System Level Export endpoint is not supported as required.'
        pass system_export_endpoint_note if system_export_endpoint_note.present?
      end
    end
  end
end
