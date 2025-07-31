# frozen_string_literal: true

require_relative 'client_authentication_token_request_group/client_generates_one_time_jwt_test'
require_relative 'client_authentication_token_request_group/client_jwt_construction_test'
require_relative 'client_authentication_token_request_group/client_requests_access_token_post_test'
require_relative 'client_authentication_token_request_group/client_token_request_parameters_test'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientAuthenticationAndTokenRequest < Inferno::TestGroup
      id :bulk_data_v200_client_authentication_and_token_request
      title 'Client Authentication & Token Request (JWT, Parameters, etc.)'
      run_as_group

      test from: :client_generates_one_time_jwt
      test from: :client_requests_access_token_via_post
      test from: :client_token_request_parameters
      test from: :client_jwt_construction
    end
  end
end
