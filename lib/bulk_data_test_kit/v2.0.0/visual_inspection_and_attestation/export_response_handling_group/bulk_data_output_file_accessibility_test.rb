# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataOutputFileAccessibilityAttestationTest < Inferno::Test
      title 'Allows for access to Bulk Data output files at advertised URLs'
      id :bulkdata_output_file_accessibility
      description %(
        When a Bulk Data server responds to a successful Status Request that has completed, the files linked in the
        response are accessible to the client at the URLs advertised.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@148'

      input :output_file_accessibility_correct,
            title: 'Bulk Data Export Response Handling: Allows for access to Bulk Data output files at advertised URLs',
            description: %(
              I attest that when a Bulk Data server responds to a successful Status Request that has completed, the
              files linked in the response are accessible to the client at the URLs advertised.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :output_file_accessibility_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert output_file_accessibility_correct == 'true',
               'Bulk Data output files are not accessible at advertised URLs.'
        pass output_file_accessibility_note if output_file_accessibility_note.present?
      end
    end
  end
end
