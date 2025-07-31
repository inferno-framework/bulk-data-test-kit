# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class OutputFileServerReturnsBulkDataFilesAttestationTest < Inferno::Test
      title 'Returns Bulk Data files in response to manifest URLs'
      id :bulkdata_output_file_server_bulkdata_files
      description %(
        The Output File Server returns FHIR Bulk Data files in response to URLs in the completion manifest.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@24'

      input :output_file_server_bulkdata_files_correct,
            title: 'Bulk Data Export Actors and Roles: Returns Bulk Data files in response to manifest URLs',
            description: %(
              I attest that the Output File Server returns FHIR Bulk Data files in response to URLs in the completion
              manifest.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :output_file_server_bulkdata_files_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert output_file_server_bulkdata_files_correct == 'true',
               'Output File Server does not return Bulk Data files in response to manifest URLs.'
        pass output_file_server_bulkdata_files_note if output_file_server_bulkdata_files_note.present?
      end
    end
  end
end
