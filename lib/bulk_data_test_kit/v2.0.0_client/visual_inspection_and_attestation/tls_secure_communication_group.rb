# frozen_string_literal: true

require_relative 'tls_secure_communication_group/bulk_data_client_tls_all_exchanges_test'
require_relative 'tls_secure_communication_group/bulk_data_client_tls_token_endpoint_test'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientTls < Inferno::TestGroup
      id :bulk_data_v200_client_tls
      title 'Transport Layer Security (TLS) and Secure Communication'
      run_as_group

      test from: :bulkdata_client_tls_all_exchanges
      test from: :bulkdata_client_tls_token_endpoint
    end
  end
end
