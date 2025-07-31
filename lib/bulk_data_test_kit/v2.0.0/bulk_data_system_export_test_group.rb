# frozen_string_literal: true

require_relative 'system_export/bulk_data_system_export_cancel_group'
require_relative 'system_export/bulk_data_system_export_parameters_group'
require_relative '../v1.0.1/system_export/bulk_data_system_export_group'
require_relative '../v1.0.1/system_export/bulk_data_system_export_validation_group'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemExportTestGroup < Inferno::TestGroup
      title 'Bulk Data System Level Export API Tests'
      id :bulk_data_system_export_v200
      run_as_group

      description %(
        The Bulk Data Access API Tests evaluate the ability of a system (Bulk
        Data Server) to support required Bulk Data $export operation.
      )

      group from: :bulk_data_system_export_group,
            title: 'System Level Export Tests STU2',
            id: :bulk_data_system_export_group_stu2,
            config: {
              options: { require_absolute_urls_in_output: true }
            } do
              verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@223', 'hl7.fhir.uv.bulkdata_2.0.0@229'

              # re-using the stu1 group for stu2, but need to update requirements in the children to v2.0.0
              children.find { |child| child.id.ends_with?('bulk_data_system_no_auth_reject') }
                      .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@9',
                                             'hl7.fhir.uv.bulkdata_2.0.0@27',
                                             'hl7.fhir.uv.bulkdata_2.0.0@226')
              children.find { |child| child.id.ends_with?('bulk_data_system_output_check') }
                      .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@164',
                                             'hl7.fhir.uv.bulkdata_2.0.0@165',
                                             'hl7.fhir.uv.bulkdata_2.0.0@166',
                                             'hl7.fhir.uv.bulkdata_2.0.0@168',
                                             'hl7.fhir.uv.bulkdata_2.0.0@169',
                                             'hl7.fhir.uv.bulkdata_2.0.0@170',
                                             'hl7.fhir.uv.bulkdata_2.0.0@175')
              children.find { |child| child.id.ends_with?('bulk_data_system_status_check') }
                      .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@132',
                                             'hl7.fhir.uv.bulkdata_2.0.0@144',
                                             'hl7.fhir.uv.bulkdata_2.0.0@145',
                                             'hl7.fhir.uv.bulkdata_2.0.0@147',
                                             'hl7.fhir.uv.bulkdata_2.0.0@150',
                                             'hl7.fhir.uv.bulkdata_2.0.0@151',
                                             'hl7.fhir.uv.bulkdata_2.0.0@152',
                                             'hl7.fhir.uv.bulkdata_2.0.0@155',
                                             'hl7.fhir.uv.bulkdata_2.0.0@156',
                                             'hl7.fhir.uv.bulkdata_2.0.0@157',
                                             'hl7.fhir.uv.bulkdata_2.0.0@159',
                                             'hl7.fhir.uv.bulkdata_2.0.0@160',
                                             'hl7.fhir.uv.bulkdata_2.0.0@161',
                                             'hl7.fhir.uv.bulkdata_2.0.0@191',
                                             'hl7.fhir.uv.bulkdata_2.0.0@192',
                                             'hl7.fhir.uv.bulkdata_2.0.0@193')
              children.find { |child| child.id.ends_with?('bulk_data_system_kick_off') }
                      .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@28',
                                             'hl7.fhir.uv.bulkdata_2.0.0@227',
                                             'hl7.fhir.uv.bulkdata_2.0.0@300',
                                             'hl7.fhir.uv.bulkdata_2.0.0@301')
            end

      group from: :bulk_data_system_export_validation,
            title: 'System Level Export Validation Tests STU2',
            id: :bulk_data_system_export_validation_stu2 do
              # re-using the stu1 group for stu2, but need to update requirements in the children to v2.0.0
              children.find { |child| child.id.ends_with?('bulk_data_system_valid_resources') }
                      .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@207',
                                             'hl7.fhir.uv.bulkdata_2.0.0@208',
                                             'hl7.fhir.uv.bulkdata_2.0.0@209')
            end

      group from: :bulk_data_system_export_cancel_group_stu2
      group from: :bulk_data_system_export_parameters_group
    end
  end
end
