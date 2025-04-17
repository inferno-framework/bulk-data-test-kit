require 'smart_app_launch_test_kit'
require_relative 'bulk_data_client_token_verification_test'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientDataAuthVerification < Inferno::TestGroup
      id :bulk_data_client_auth_verification
      title 'Review Authentication Interactions'
      run_as_group

      test from: :bulk_data_client_token_smart_bsca_verification
      test from: :smart_client_token_use_verification,
           config: {
             options: { access_request_tags: [KICKOFF_TAG, STATUS_TAG, OUTPUT_TAG, DELETE_TAG] }
           }

    end
  end
end