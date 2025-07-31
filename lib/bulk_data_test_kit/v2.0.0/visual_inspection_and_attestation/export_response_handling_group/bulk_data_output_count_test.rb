# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataOutputCountAttestationTest < Inferno::Test
      title 'Includes count of number of resources in the file'
      id :bulkdata_output_count
      description %(
        The Bulk Data output includes the `count` field representing the number of resources in the file, as a
        JSON number.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@178'

      input :output_count_correct,
            title: 'Bulk Data Export Response Handling: Includes count of number of resources in the file',
            description: %(
              I attest that the Bulk Data output includes the `count` field representing the number of resources in
              the file, as a JSON number.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :output_count_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert output_count_correct == 'true',
               'Bulk Data output does not include count of resources in file.'
        pass output_count_note if output_count_note.present?
      end
    end
  end
end
