# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class TypeParameterAttestationTest < Inferno::Test
      title 'Filters response to specified resource types in Bulk Data _type parameter'
      id :bulkdata_type_parameter
      description %(
        The `_type` parameter filters the response to only include resources of the specified resource type(s)
        and if omitted, the server returns all supported resources within the scope of client authorization.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@62',
                            'hl7.fhir.uv.bulkdata_2.0.0@63'

      input :type_parameter_correct,
            title: %(
              Bulk Data Export Query Parameters: Filters response to specified resource types in Bulk Data _type
              parameter
            ),
            description: %(
              I attest that the `_type` parameter filters the response to only include resources of the specified
              resource type(s) and if omitted, the server returns all supported resources within the scope of client
              authorization.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :type_parameter_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert type_parameter_correct == 'true',
               'Bulk Data _type parameter does not filter or return resources as required.'
        pass type_parameter_note if type_parameter_note.present?
      end
    end
  end
end
