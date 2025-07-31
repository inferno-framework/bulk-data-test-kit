# frozen_string_literal: true

require_relative 'bulk_data_export_endpoints_operations_group/bulk_data_group_export_endpoint_test'
require_relative 'bulk_data_export_endpoints_operations_group/bulk_data_kickoff_get_request_test'
require_relative 'bulk_data_export_endpoints_operations_group/bulk_data_output_file_requests_test'
require_relative 'bulk_data_export_endpoints_operations_group/bulk_data_patient_export_endpoint_test'
require_relative 'bulk_data_export_endpoints_operations_group/bulk_data_status_request_endpoint_test'
require_relative 'bulk_data_export_endpoints_operations_group/bulk_data_system_export_endpoint_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataExportEndpointsOperationsAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_bulk_data_export_endpoints_operations
      title 'Bulk Data Export Endpoints and Operations'

      run_as_group
      test from: :bulkdata_group_export_endpoint
      test from: :bulkdata_kickoff_get_request
      test from: :bulkdata_patient_export_endpoint
      test from: :bulkdata_status_request_endpoint
      test from: :bulkdata_output_file_requests
      test from: :bulkdata_system_export_endpoint
    end
  end
end
