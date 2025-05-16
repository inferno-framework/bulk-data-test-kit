require 'smart_app_launch_test_kit'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientDataTokenSMARTConfidentialAsymmetricVerification <
      SMARTAppLaunch::SMARTClientTokenRequestBackendServicesConfidentialAsymmetricVerification
      id :bulk_data_client_token_smart_bsca_verification

      def client_suite_id
        BulkDataClientTestSuite.id
      end
    end
  end
end
