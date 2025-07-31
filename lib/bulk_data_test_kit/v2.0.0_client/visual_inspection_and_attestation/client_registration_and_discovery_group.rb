# frozen_string_literal: true

require_relative 'client_registration_and_discovery_group/smart_client_discover_configuration_test'
require_relative 'client_registration_and_discovery_group/smart_client_registration_test'
require_relative 'client_registration_and_discovery_group/smart_client_retrieve_configuration_file_test'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientRegistrationAndDiscovery < Inferno::TestGroup
      id :bulk_data_v200_client_registration_and_discovery
      title 'SMART Backend Services Client Registration and Discovery'
      run_as_group

      test from: :smart_client_registration
      test from: :smart_client_discover_configuration
      test from: :smart_client_retrieve_configuration_file
    end
  end
end
