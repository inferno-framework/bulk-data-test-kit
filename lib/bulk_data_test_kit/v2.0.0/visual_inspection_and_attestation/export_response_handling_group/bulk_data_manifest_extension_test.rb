# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataManifestExtensionAttestationTest < Inferno::Test
      title 'Allows for optional Bulk Data manifest extension field'
      id :bulkdata_manifest_extension
      description %(
        The Bulk Data manifest extension field is optional and, if present, is a JSON object.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@198',
                            'hl7.fhir.uv.bulkdata_2.0.0@199'

      input :manifest_extension_correct,
            title: 'Bulk Data Export Response Handling: Allows for optional Bulk Data manifest extension field',
            description: %(
              I attest that the Bulk Data manifest extension field is optional and, if present, is a JSON object.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :manifest_extension_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert manifest_extension_correct == 'true',
               'Bulk Data manifest extension field is not optional or not a JSON object.'
        pass manifest_extension_note if manifest_extension_note.present?
      end
    end
  end
end
