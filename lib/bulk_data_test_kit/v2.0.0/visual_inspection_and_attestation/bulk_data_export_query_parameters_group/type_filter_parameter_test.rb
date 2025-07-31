# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class TypeFilterParameterAttestationTest < Inferno::Test
      title 'Filters data as specified in Bulk Data _typeFilter parameter'
      id :bulkdata_type_filter_parameter
      description %(
        If supported, the `_typeFilter` parameter causes the server to filter the data in the response to only
        include resources that meet the specified criteria. If repeated, the server treats repeated values as
        if they were comma-delimited within a single parameter.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@103',
                            'hl7.fhir.uv.bulkdata_2.0.0@117'

      input :type_filter_parameter_correct,
            title: 'Bulk Data Export Query Parameters: Filters data as specified in Bulk Data _typeFilter parameter',
            description: %(
              I attest that if supported, the `_typeFilter` parameter causes the server to filter the data in the
              response to only include resources that meet the specified criteria. If repeated, the server treats
              repeated values as if they were comma-delimited within a single parameter.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :type_filter_parameter_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert type_filter_parameter_correct == 'true',
               'Bulk Data _typeFilter parameter is not handled as required.'
        pass type_filter_parameter_note if type_filter_parameter_note.present?
      end
    end
  end
end
