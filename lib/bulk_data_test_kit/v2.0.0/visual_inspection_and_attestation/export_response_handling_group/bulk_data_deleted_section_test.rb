# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataDeletedSectionAttestationTest < Inferno::Test
      title 'Conforms to specification in bulk data manifest deleted section'
      id :bulkdata_deleted_section
      description %(
        The Bulk Data manifest deleted section:
        - Is a required JSON array.
        - Follows the same structure as the output array.
        - Resources in the deleted section do not appear in the output section.
        - Each line in the output file is a FHIR Bundle of type transaction.
        - Each transaction contains one or more entry items reflecting a deleted resource.
        - Each entry has request.url and request.method populated.
        - request.method is set to DELETE.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@180',
                            'hl7.fhir.uv.bulkdata_2.0.0@181',
                            'hl7.fhir.uv.bulkdata_2.0.0@186',
                            'hl7.fhir.uv.bulkdata_2.0.0@187',
                            'hl7.fhir.uv.bulkdata_2.0.0@188',
                            'hl7.fhir.uv.bulkdata_2.0.0@189',
                            'hl7.fhir.uv.bulkdata_2.0.0@190'

      input :deleted_section_correct,
            title: %(
             Bulk Data Export Response Handling: Conforms to specification in bulk data manifest deleted section
            ),
            description: %(
              I attest that the Bulk Data manifest deleted section:
              - Is a required JSON array.
              - Follows the same structure as the output array.
              - Resources in the deleted section do not appear in the output section.
              - Each line in the output file is a FHIR Bundle of type transaction.
              - Each transaction contains one or more entry items reflecting a deleted resource.
              - Each entry has request.url and request.method populated.
              - request.method is set to DELETE.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :deleted_section_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert deleted_section_correct == 'true',
               'Bulk Data manifest deleted section does not conform to specification.'
        pass deleted_section_note if deleted_section_note.present?
      end
    end
  end
end
