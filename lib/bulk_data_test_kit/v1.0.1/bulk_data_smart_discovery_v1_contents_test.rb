module BulkDataTestKit
  module BulkDataV101
    class BulkDataSmartDiscoveryV1ContentsTest < Inferno::Test
      title 'Well-known configuration contains the required fields'
      id :bulk_data_smart_discovery_v1_contents

      description %(
        The [Bulk Data v1.0.1 SMART Backend Services IG](https://hl7.org/fhir/uv/bulkdata/STU1.0.1/authorization/index.html#advertising-server-conformance-with-smart-backend-services) states:
        > A server MAY advertise its conformance with SMART Backend Services, by hosting a Well-Known Uniform Resource
        > Identifiers (URIs) (RFC5785) JSON document as described at SMART App Launch Authorization Discovery. If
        > advertising support, a server’s /.well-known/smart-configuration endpoint SHOULD include token_endpoint,
        > scopes_supported, token_endpoint_auth_methods_supported (with values that include private_key_jwt), and
        > token_endpoint_auth_signing_alg_values_supported (with values that include at least one of RS384, ES384)
        > attributes for backend services. The response is a JSON document using the application/json mime type.

        This test requires a valid `token_endpoint` claim to pass but issue a warning for all other claims.
      )

      input :well_known_configuration

      output :smart_token_url

      def test_key(config, key, type)
        assert config.key?(key), "Well-known configuration does not include `#{key}`"
        assert config[key].present?, "Well-known configuration field `#{key}` is blank"
        assert config[key].is_a?(type), "Well-known `#{key}` must be type: #{type.to_s.downcase}"
      end

      run do
        config = JSON.parse(well_known_configuration)

        # token_endpoint must be output for downstream tests to work
        test_key(config, 'token_endpoint', String)
        token_endpoint = config['token_endpoint']
        assert token_endpoint.match?(URI::DEFAULT_PARSER.make_regexp), "`#{token_endpoint}` is not a valid URI"

        output smart_token_url: token_endpoint

        recommended_capabilities = [
          'token_endpoint_auth_methods_supported',
          'token_endpoint_auth_signing_alg_values_supported',
          'scopes_supported'
        ]

        warning do
          recommended_capabilities.each do |key|
            test_key(config, key, Array)
          end

          assert config['token_endpoint_auth_methods_supported'].include?('private_key_jwt'),
                '`token_endpoint_auth_methods_supported` does not include the value `private_key_jwt`'

          supports_RS384 = config['token_endpoint_auth_signing_alg_values_supported'].include? 'RS384'
          supports_ES384 = config['token_endpoint_auth_signing_alg_values_supported'].include? 'ES384'

          err_msg = '`token_endpoint_auth_signing_alg_values_supported` does not include values for `RS384` or `ES384`'
          assert (supports_RS384 || supports_ES384), err_msg
        end
      end
    end
  end
end
