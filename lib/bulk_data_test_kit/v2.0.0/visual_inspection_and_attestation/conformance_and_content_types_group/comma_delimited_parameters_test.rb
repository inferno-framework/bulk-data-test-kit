# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class CommaDelimitedParametersAttestationTest < Inferno::Test
      title 'Treats repeated parameter values as comma-delimited'
      id :bulkdata_comma_delimited_parameters
      description %(
        The Bulk Data server treats repeated parameter values as if they were comma-delimited values within a single
        instance of the parameter, as required by the specification.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@32'

      input :comma_delimited_parameters_correct,
            title: 'Conformance and Content Types: Treats repeated parameter values as comma-delimited',
            description: %(
              I attest that the Bulk Data server treats repeated parameter values as if they were comma-delimited
              values within a single instance of the parameter, as required by the specification.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :comma_delimited_parameters_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert comma_delimited_parameters_correct == 'true',
               'Bulk Data server does not treat repeated parameter values as comma-delimited.'
        pass comma_delimited_parameters_note if comma_delimited_parameters_note.present?
      end
    end
  end
end
