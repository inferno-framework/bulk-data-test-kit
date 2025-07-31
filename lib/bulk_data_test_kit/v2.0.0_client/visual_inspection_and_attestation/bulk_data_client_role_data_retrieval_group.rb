# frozen_string_literal: true

require_relative 'bulk_data_client_role_data_retrieval_group/bulk_data_client_access_token_file_request_test'
require_relative 'bulk_data_client_role_data_retrieval_group/bulk_data_client_authorization_header_test'
require_relative 'bulk_data_client_role_data_retrieval_group/bulk_data_client_receives_files_test'
require_relative 'bulk_data_client_role_data_retrieval_group/bulk_data_confidential_client_requirement_test'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientDataRetrieval < Inferno::TestGroup
      id :bulk_data_v200_client_data_retrieval
      title 'Bulk Data Client Role and Data Retrieval'
      run_as_group

      test from: :bulkdata_client_receives_files
      test from: :bulkdata_client_access_token_for_file_request
      test from: :bulkdata_client_authorization_header
      test from: :confidential_client_requirement
    end
  end
end
