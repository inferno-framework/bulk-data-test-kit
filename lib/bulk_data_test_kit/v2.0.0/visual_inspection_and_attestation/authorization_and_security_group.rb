# frozen_string_literal: true

require_relative 'authorization_and_security_group/bulk_data_access_token_protection_test'
require_relative 'authorization_and_security_group/bulk_data_access_token_scope_enforcement_test'
require_relative 'authorization_and_security_group/bulk_data_attachment_url_access_test'
require_relative 'authorization_and_security_group/bulk_data_invalid_client_error_test'
require_relative 'authorization_and_security_group/bulk_data_jwk_registration_test'
require_relative 'authorization_and_security_group/bulk_data_jwks_caching_test'
require_relative 'authorization_and_security_group/bulk_data_jwt_validation_test'
require_relative 'authorization_and_security_group/bulk_data_requires_access_token_field_test'
require_relative 'authorization_and_security_group/bulk_data_risk_based_token_requirement_test'
require_relative 'authorization_and_security_group/bulk_data_scope_mediation_test'
require_relative 'authorization_and_security_group/bulk_data_short_lived_access_token_test'
require_relative 'authorization_and_security_group/bulk_data_smart_discovery_test'
require_relative 'authorization_and_security_group/bulk_data_smart_symmetric_profile_not_used_test'
require_relative 'authorization_and_security_group/bulk_data_tls_test'

module BulkDataTestKit
  module BulkDataV200
    class AuthorizationAndSecurityAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_authorization_security_group
      title 'Authorization, Authentication, and Security'

      run_as_group
      test from: :bulkdata_access_token_protection
      test from: :bulkdata_access_token_scope_enforcement
      test from: :bulkdata_scope_mediation
      test from: :bulkdata_attachment_url_access
      test from: :bulkdata_jwk_registration
      test from: :bulkdata_jwks_caching
      test from: :bulkdata_jwt_validation
      test from: :bulkdata_requires_access_token_field
      test from: :bulkdata_risk_based_token_requirement
      test from: :bulkdata_short_lived_access_token
      test from: :bulkdata_smart_discovery
      test from: :bulkdata_smart_symmetric_profile_not_used
      test from: :bulkdata_tls
      test from: :bulk_data_invalid_client_error
    end
  end
end
