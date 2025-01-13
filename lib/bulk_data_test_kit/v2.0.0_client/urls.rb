# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    RESUME_PASS_PATH = '/resume_pass'
    BASE_ROUTE = '/fhir'
    METADATA_ROUTE = "#{BASE_ROUTE}/metadata".freeze
    PATIENT_KICKOFF_ROUTE = "#{BASE_ROUTE}/:type/$export".freeze
    GROUP_KICKOFF_ROUTE = "#{BASE_ROUTE}/:type/:group_id/$export".freeze
    SYSTEM_KICKOFF_ROUTE = "#{BASE_ROUTE}/$export".freeze
    STATUS_ROUTE = '/status'
    OUTPUT_ROUTE = '/output/example.ndjson'

    # URLs for use in Bulk Data Client tests and endpoints
    module URLs
      def base_url
        "#{Inferno::Application['base_url']}/custom/#{suite_id}"
      end

      def resume_pass_url
        base_url + RESUME_PASS_PATH
      end

      def kickoff_url
        base_url + BASE_ROUTE
      end

      def status_url
        base_url + STATUS_ROUTE
      end

      def output_url
        base_url + OUTPUT_ROUTE
      end

      def suite_id
        if respond_to?('result') # If being used with a suite endpoint
          result.test_id.split('-').first
        elsif self.class.respond_to?('suite') # If being used with a test/group/suite
          self.class.suite.id
        end
      end
    end
  end
end
