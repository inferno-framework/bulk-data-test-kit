# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class PatientParameterAttestationTest < Inferno::Test
      title 'Restricts response to specified patients in Bulk Data patient parameter'
      id :bulkdata_patient_parameter
      description %(
        When the `patient` parameter is provided, the server does not return resources in the patient compartments
        belonging to patients outside of this list.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@85'

      input :patient_parameter_correct,
            title: %(
              Bulk Data Export Query Parameters: Restricts response to specified patients in Bulk Data patient
              parameter
            ),
            description: %(
              I attest that when the `patient` parameter is provided, the server does not return resources in the
              patient compartments belonging to patients outside of this list.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :patient_parameter_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert patient_parameter_correct == 'true',
               'Bulk Data patient parameter does not restrict resources as required.'
        pass patient_parameter_note if patient_parameter_note.present?
      end
    end
  end
end
