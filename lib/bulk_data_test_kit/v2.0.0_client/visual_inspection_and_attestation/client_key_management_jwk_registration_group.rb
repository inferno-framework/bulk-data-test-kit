# frozen_string_literal: true

require_relative 'client_key_management_jwk_registration_group/client_generates_obtains_asymmetric_key_test'
require_relative 'client_key_management_jwk_registration_group/client_jwk_communication_method_test'
require_relative 'client_key_management_jwk_registration_group/client_jwk_ecdsa_properties_test'
require_relative 'client_key_management_jwk_registration_group/client_jwk_properties_test'
require_relative 'client_key_management_jwk_registration_group/client_jwk_rsa_properties_test'
require_relative 'client_key_management_jwk_registration_group/client_jwk_set_url_accessible_test'
require_relative 'client_key_management_jwk_registration_group/client_jwk_set_url_tls_test'
require_relative 'client_key_management_jwk_registration_group/client_jws_support_test'
require_relative 'client_key_management_jwk_registration_group/client_protects_private_key_test'
require_relative 'client_key_management_jwk_registration_group/client_registers_public_key_set_test'
require_relative 'client_key_management_jwk_registration_group/client_supports_es384_test'
require_relative 'client_key_management_jwk_registration_group/client_supports_rs384_test'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkClientKeyManagement < Inferno::TestGroup
      id :bulk_data_v200_client_key_management
      title 'Client Key Management & JWK Registration'
      run_as_group

      test from: :client_generates_or_obtains_asymmetric_key_pair
      test from: :client_registers_public_key_set
      test from: :client_protects_private_key
      test from: :client_chooses_jwk_communication_method
      test from: :client_jwk_set_url_tls
      test from: :client_jwk_set_url_accessible
      test from: :client_jws_support
      test from: :client_supports_rs384
      test from: :client_supports_es384
      test from: :client_jwk_properties
      test from: :client_jwk_rsa_properties
      test from: :client_jwk_ecdsa_properties
    end
  end
end
