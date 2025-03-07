# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module ServerProxy
      include URLs

      def proxy_client
        @proxy_client ||= Faraday.new(
          url: ENV.fetch('FHIR_REFERENCE_SERVER'),
          params: {},
          headers: request_headers
        ) do |proxy|
          proxy.use FaradayMiddleware::Gzip
          proxy.options.params_encoder = Faraday::FlatParamsEncoder
        end
      end

      def rewrite_url_base(url)
        url.gsub(ENV.fetch('FHIR_REFERENCE_SERVER'), fhir_url)
      end

      def request_headers
        {
          'Content-Type' => 'application/json',
          'Authorization' => 'Bearer SAMPLE_TOKEN',
          'Prefer' => 'respond-async'
        }
      end
    end
  end
end
