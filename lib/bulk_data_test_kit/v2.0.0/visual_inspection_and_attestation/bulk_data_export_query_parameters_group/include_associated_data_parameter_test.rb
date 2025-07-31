# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class IncludeAssociatedDataParameterAttestationTest < Inferno::Test
      title 'Returns or omits associated resources in Bulk Data includeAssociatedData parameter'
      id :bulkdata_include_associated_data_parameter
      description %(
        If supported, the `includeAssociatedData` parameter causes the server to return or omit a pre-defined set of
        FHIR resources associated with the request, and if multiple conflicting values are included, the server
        applies the least restrictive value (returns the largest dataset).
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@92',
                            'hl7.fhir.uv.bulkdata_2.0.0@96'

      input :include_associated_data_parameter_correct,
            title: %(
              Bulk Data Export Query Parameters: Returns or omits associated resources in Bulk Data
              includeAssociatedData parameter
            ),
            description: %(
              I attest that if supported, the `includeAssociatedData` parameter causes the server to return or omit a
              pre-defined set of FHIR resources associated with the request, and if multiple conflicting values are
              included, the server applies the least restrictive value (returns the largest dataset).
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :include_associated_data_parameter_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert include_associated_data_parameter_correct == 'true',
               'Bulk Data includeAssociatedData parameter is not handled as required.'
        pass include_associated_data_parameter_note if include_associated_data_parameter_note.present?
      end
    end
  end
end
