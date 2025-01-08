# frozen_string_literal: true

require_relative '../bulk_export_validation_tester'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataValidResourcesTest < Inferno::Test
      include BulkDataTestKit::BulkExportValidationTester

      id :bulk_data_valid_resources

      title 'All resources returned are valid FHIR resources'
      description <<~DESCRIPTION
        This test verifies that the resources returned from bulk data export
        conform to the base FHIR standard. This includes checking for missing
        data elements and value set verification. This test caps the number of
        validation info and warning messages that it will display to 50 and the
        number of error messages it will display to 20.
      DESCRIPTION

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@33',
                            'hl7.fhir.uv.bulkdata_2.0.0@34',
                            'hl7.fhir.uv.bulkdata_2.0.0@35',
                            'hl7.fhir.uv.bulkdata_2.0.0@36',
                            'hl7.fhir.uv.bulkdata_2.0.0@45',
                            'hl7.fhir.uv.bulkdata_2.0.0@46',
                            'hl7.fhir.uv.bulkdata_2.0.0@205',
                            'hl7.fhir.uv.bulkdata_2.0.0@207',
                            'hl7.fhir.uv.bulkdata_2.0.0@208',
                            'hl7.fhir.uv.bulkdata_2.0.0@209'

      input :status_output
      input :requires_access_token

      run do
        perform_bulk_export_validation(bulk_status_output: status_output,
                                       bulk_requires_access_token: requires_access_token)
      end
    end
  end
end
