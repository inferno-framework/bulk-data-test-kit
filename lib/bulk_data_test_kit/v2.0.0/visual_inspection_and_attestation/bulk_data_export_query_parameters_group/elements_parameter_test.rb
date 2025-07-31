# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class ElementsParameterAttestationTest < Inferno::Test
      title 'Allows only root elements in Bulk Data _elements parameter'
      id :bulkdata_elements_parameter
      description %(
        The `_elements` parameter only permits root elements in a resource.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@77'

      input :elements_parameter_correct,
            title: 'Bulk Data Export Query Parameters: Allows only root elements in Bulk Data _elements parameter',
            description: %(
              I attest that the `_elements` parameter only permits root elements in a resource.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :elements_parameter_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert elements_parameter_correct == 'true',
               'Bulk Data _elements parameter does not restrict to root elements.'
        pass elements_parameter_note if elements_parameter_note.present?
      end
    end
  end
end
