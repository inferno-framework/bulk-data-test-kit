require_relative '../bulk_export_validation_tester'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataMultiplePatientsTest < Inferno::Test
      include BulkDataTestKit::BulkExportValidationTester

      id :bulk_data_multiple_patients

      title 'Export has at least two patients'
      description <<~DESCRIPTION
        This test verifies that the bulk data export has at least two patients.
      DESCRIPTION
      # link 'http://ndjson.org/'
  
      run do
        export_multiple_patients_check
      end
    end
  end
end