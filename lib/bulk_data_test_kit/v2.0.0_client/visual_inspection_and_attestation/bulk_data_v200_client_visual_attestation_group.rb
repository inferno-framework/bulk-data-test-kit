# frozen_string_literal: true

require_relative 'bulk_data_client_role_data_retrieval_group'
require_relative 'client_authentication_token_request_group'
require_relative 'client_key_management_jwk_registration_group'
require_relative 'client_registration_and_discovery_group'
require_relative 'tls_secure_communication_group'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkDataV200ClientAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_client_visual_inspection_and_attestation
      title 'Visual Inspection and Attestation'

      description <<~DESCRIPTION
        Perform visual inspections or attestations to ensure that the Client is conformant to the Bulk Data
        requirements.
      DESCRIPTION

      group from: :bulk_data_v200_client_data_retrieval
      group from: :bulk_data_v200_client_authentication_and_token_request
      group from: :bulk_data_v200_client_registration_and_discovery
      group from: :bulk_data_v200_client_tls
      group from: :bulk_data_v200_client_key_management
    end
  end
end
