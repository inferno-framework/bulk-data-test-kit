require_relative '../../bulk_export_validation_tester'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupMatchingPatientIDsTest < Inferno::Test
      include BulkDataTestKit::BulkExportValidationTester

      id :bulk_data_group_matching_patient_ids

      title 'Patient IDs match those expected in Group'
      description <<~DESCRIPTION
        This test checks that the list of patient IDs that are expected match those that are returned.
        If no patient ids are provided to the test, then the test will be omitted.
      DESCRIPTION
      # link 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'

      run do
        expected_patient_ids_check
      end
    end
  end
end