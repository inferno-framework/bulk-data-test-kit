# frozen_string_literal: true

require_relative 'scopes_and_access_group/pre_authorized_client_test'
require_relative 'scopes_and_access_group/scope_response_test'
require_relative 'scopes_and_access_group/scope_restriction_test'

module BulkDataTestKit
  module BulkDataV200
    class ScopesAndAccessAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_scopes_and_access
      title 'Scopes and Access'

      run_as_group
      test from: :smart_pre_authorized_client
      test from: :smart_scope_response
      test from: :smart_scope_restriction
    end
  end
end
