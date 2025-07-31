# frozen_string_literal: true

require 'smart_app_launch_test_kit'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientDataRegistration < Inferno::TestGroup
      id :bulk_data_client_registration
      title 'Client Registration'
      run_as_group

      test from: :smart_client_registration_bsca_verification
    end
  end
end
