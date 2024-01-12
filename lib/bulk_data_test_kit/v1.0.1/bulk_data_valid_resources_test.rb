require_relative '../bulk_export_validation_tester'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataValidResourcesTest < Inferno::Test
      include BulkDataTestKit::BulkExportValidationTester

      id :bulk_data_valid_resources
  
      title 'All resources returned are valid FHIR resources'
      description <<~DESCRIPTION
        This test verifies that the resources returned from bulk data export
        conform to the US Core Patient profile. This includes checking for missing data
        elements and value set verification.
      DESCRIPTION
      # link 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'

      input :status_output
      input :requires_access_token

      run do
        perform_bulk_export_validation(bulk_status_output: status_output, bulk_requires_access_token: requires_access_token)
      end
    end
  end
end