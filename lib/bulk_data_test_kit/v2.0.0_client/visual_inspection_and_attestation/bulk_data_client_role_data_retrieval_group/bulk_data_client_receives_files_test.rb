# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class BulkDataClientReceivesFilesAttestationTest < Inferno::Test
      title 'Receives Bulk Data files'
      id :bulkdata_client_receives_files
      description %(
        The Bulk Data Client is a system that receives Bulk Data files from the Bulk Data Provider.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@18'

      input :client_receives_files_correct,
            title: 'Bulk Data Client Role and Data Retrieval: Receives Bulk Data files',
            description: %(
              I attest that the Bulk Data Client is a system that receives Bulk Data files from the Bulk Data Provider.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_receives_files_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_receives_files_correct == 'true',
               'Bulk Data Client does not receive Bulk Data files as required.'
        pass client_receives_files_note if client_receives_files_note.present?
      end
    end
  end
end
