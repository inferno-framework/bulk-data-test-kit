# frozen_string_literal: true

require_relative 'authorization_and_security_group'
require_relative 'bulk_data_export_actors_roles_group'
require_relative 'bulk_data_export_endpoints_operations_group'
require_relative 'bulk_data_export_query_parameters_group'
require_relative 'conformance_and_content_types_group'
require_relative 'export_response_handling_group'
require_relative 'scopes_and_access_group'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataV200AttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_visual_inspection_and_attestation
      title 'Visual Inspection and Attestation'

      description <<~DESCRIPTION
        Perform visual inspections or attestations to ensure that the Server is conformant to the Bulk Data
        requirements.
      DESCRIPTION

      group from: :bulk_data_v200_authorization_security_group
      group from: :bulk_data_v200_bulk_data_export_actors_roles
      group from: :bulk_data_v200_bulk_data_export_endpoints_operations
      group from: :bulk_data_v200_bulk_data_export_query_parameters
      group from: :bulk_data_v200_export_response_handling
      group from: :bulk_data_v200_scopes_and_access
      group from: :bulk_data_v200_conformance_and_content_types
    end
  end
end
