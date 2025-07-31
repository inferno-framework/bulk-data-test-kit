# frozen_string_literal: true

require_relative 'export_response_handling_group/bulk_data_attachment_url_test'
require_relative 'export_response_handling_group/bulk_data_deleted_section_test'
require_relative 'export_response_handling_group/bulk_data_error_file_test'
require_relative 'export_response_handling_group/bulk_data_kickoff_error_response_test'
require_relative 'export_response_handling_group/bulk_data_manifest_extension_test'
require_relative 'export_response_handling_group/bulk_data_most_recent_version_test'
require_relative 'export_response_handling_group/bulk_data_output_count_test'
require_relative 'export_response_handling_group/bulk_data_output_file_accessibility_test'
require_relative 'export_response_handling_group/bulk_data_output_file_error_test'
require_relative 'export_response_handling_group/bulk_data_output_file_success_test'
require_relative 'export_response_handling_group/bulk_data_partial_success_test'
require_relative 'export_response_handling_group/bulk_data_request_url_test'
require_relative 'export_response_handling_group/bulk_data_status_error_response_test'
require_relative 'export_response_handling_group/bulk_data_transaction_time_test'

module BulkDataTestKit
  module BulkDataV200
    class ExportResponseHandlingAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_export_response_handling
      title 'Bulk Data Export Response Handling'

      run_as_group
      test from: :bulkdata_attachment_url
      test from: :bulkdata_deleted_section
      test from: :bulkdata_error_file
      test from: :bulkdata_kickoff_error_response
      test from: :bulkdata_manifest_extension
      test from: :bulkdata_most_recent_version
      test from: :bulkdata_output_count
      test from: :bulkdata_output_file_accessibility
      test from: :bulkdata_output_file_error
      test from: :bulkdata_output_file_success
      test from: :bulkdata_partial_success
      test from: :bulkdata_request_url
      test from: :bulkdata_status_error_response
      test from: :bulkdata_transaction_time
    end
  end
end
