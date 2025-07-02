# frozen_string_literal: true

require_relative 'group/bulk_data_group_export_cancel_group'
require_relative 'group/bulk_data_group_export_parameters_group'
require_relative '../v1.0.1/group/bulk_data_group_export_group'
require_relative '../v1.0.1/group/bulk_data_group_export_validation_group'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupTestGroup < Inferno::TestGroup
      title 'Bulk Data Group API Tests'
      id :bulk_data_group_export_v200
      run_as_group

      description %(
          The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server)
          to support required Bulk Data Group $export operation.
      )

      group from: :bulk_data_group_export_group,
            title: 'Group Compartment Export Tests STU2',
            id: :bulk_data_group_export_group_stu2,
            config: {
              options: { require_absolute_urls_in_output: true }
            } do
              verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@224',
                                    'hl7.fhir.uv.bulkdata_2.0.0@249'

              children.find { |child| child.id.ends_with?('bulk_data_group_no_auth_reject') }
                .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@9',
                                       'hl7.fhir.uv.bulkdata_2.0.0@27',
                                       'hl7.fhir.uv.bulkdata_2.0.0@226')
              children.find { |child| child.id.ends_with?('bulk_data_group_output_check') }
                .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@164',
                                       'hl7.fhir.uv.bulkdata_2.0.0@165',
                                       'hl7.fhir.uv.bulkdata_2.0.0@166',
                                       'hl7.fhir.uv.bulkdata_2.0.0@168',
                                       'hl7.fhir.uv.bulkdata_2.0.0@169',
                                       'hl7.fhir.uv.bulkdata_2.0.0@170',
                                       'hl7.fhir.uv.bulkdata_2.0.0@175')
              children.find { |child| child.id.ends_with?('bulk_data_group_status_check') }
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
              children.find { |child| child.id.ends_with?('bulk_data_group_kick_off') }
                .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@28',
                                       'hl7.fhir.uv.bulkdata_2.0.0@227',
                                       'hl7.fhir.uv.bulkdata_2.0.0@300',
                                       'hl7.fhir.uv.bulkdata_2.0.0@301')
            end
            

      group from: :bulk_data_group_export_validation,
            title: 'Group Compartment Export Validation Tests STU2',
            id: :bulk_data_group_export_validation_stu2 do
              children.find { |child| child.id.ends_with?('bulk_data_group_valid_resources') }
                .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@207',
                                       'hl7.fhir.uv.bulkdata_2.0.0@208',
                                       'hl7.fhir.uv.bulkdata_2.0.0@209')
            end

      group from: :bulk_data_group_export_cancel_group_stu2
      group from: :bulk_data_group_export_parameters_group
    end
  end
end
