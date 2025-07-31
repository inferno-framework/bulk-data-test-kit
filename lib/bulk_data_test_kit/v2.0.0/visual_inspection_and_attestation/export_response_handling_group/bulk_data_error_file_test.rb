# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataErrorFileAttestationTest < Inferno::Test
      title 'Contains OperationOutcome resources in Bulk Data error files'
      id :bulkdata_error_file
      description %(
        Only the FHIR OperationOutcome resource type is supported in error files, which are generated in the same
        format as Bulk Data output files.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@196'

      input :error_file_correct,
            title: 'Bulk Data Export Response Handling: Contains OperationOutcome resources in Bulk Data error files',
            description: %(
              I attest that only the FHIR OperationOutcome resource type is supported in error files, which are
              generated in the same format as Bulk Data output files.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :error_file_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert error_file_correct == 'true',
               'Bulk Data error files do not contain only OperationOutcome resources.'
        pass error_file_note if error_file_note.present?
      end
    end
  end
end
