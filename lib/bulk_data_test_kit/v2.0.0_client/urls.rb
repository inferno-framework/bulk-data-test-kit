# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    RESUME_PASS_ROUTE = '/resume_pass'
    BASE_ROUTE = '/fhir'
    PATIENT_KICKOFF_ROUTE = "#{BASE_ROUTE}/:type/$export".freeze
    GROUP_KICKOFF_ROUTE = "#{BASE_ROUTE}/:type/:group_id/$export".freeze
    SYSTEM_KICKOFF_ROUTE = "#{BASE_ROUTE}/$export".freeze
    STATUS_ROUTE = '/status/:job_id'
    OUTPUT_ROUTE = "#{BASE_ROUTE}/Binary/:binary_id".freeze

    # URLs for use in Bulk Data Client tests and endpoints
    module URLs
      def base_url
        "#{Inferno::Application['base_url']}/custom/#{suite_id}"
      end

      def resume_pass_url
        base_url + RESUME_PASS_ROUTE
      end

      def fhir_url
        base_url + BASE_ROUTE
      end

      def status_url
        base_url + STATUS_ROUTE
      end

      def output_url
        base_url + OUTPUT_ROUTE
      end

      def suite_id
        BulkDataClientTestSuite.id
      end
    end
  end
end
