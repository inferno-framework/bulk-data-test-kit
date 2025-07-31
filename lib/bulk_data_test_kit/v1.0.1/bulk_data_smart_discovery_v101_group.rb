# frozen_string_literal: true

require 'smart_app_launch/well_known_endpoint_test'
require_relative 'bulk_data_smart_discovery_v101_contents_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSmartDiscoveryV101Group < Inferno::TestGroup
      title 'SMART on FHIR Discovery'
      id :bulk_data_smart_discovery_v101
      run_as_group

      test from: :well_known_endpoint
      test from: :bulk_data_smart_discovery_v101_contents
    end
  end
end
