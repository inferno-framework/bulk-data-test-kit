# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class SinceParameterAttestationTest < Inferno::Test
      title 'Includes only changed resources in Bulk Data _since parameter'
      id :bulkdata_since_parameter
      description %(
        The `_since` parameter ensures that only resources whose state has changed after the supplied time are
        included in the response.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@59'

      input :since_parameter_correct,
            title: 'Bulk Data Export Query Parameters: Includes only changed resources in Bulk Data _since parameter',
            description: %(
              I attest that the `_since` parameter ensures only resources whose state has changed after the supplied
              time are included in the response.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :since_parameter_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert since_parameter_correct == 'true',
               'Bulk Data _since parameter does not filter resources as required.'
        pass since_parameter_note if since_parameter_note.present?
      end
    end
  end
end
