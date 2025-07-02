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

              children.find { |child| child.id.ends_with?('bulk_data_system_no_auth_reject') }
                .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@27')
            end

      group from: :bulk_data_system_export_validation,
            title: 'System Level Export Validation Tests STU2',
            id: :bulk_data_system_export_validation_stu2 do
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
