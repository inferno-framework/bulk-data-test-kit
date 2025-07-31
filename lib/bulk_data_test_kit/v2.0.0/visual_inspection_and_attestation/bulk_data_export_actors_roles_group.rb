# frozen_string_literal: true

require_relative 'bulk_data_export_actors_roles_group/bulk_data_provider_includes_authorization_server_test'
require_relative 'bulk_data_export_actors_roles_group/bulk_data_provider_includes_output_file_server_test'
require_relative 'bulk_data_export_actors_roles_group/bulk_data_provider_includes_resource_server_test'
require_relative 'bulk_data_export_actors_roles_group/fhir_resource_server_completion_manifest_test'
require_relative 'bulk_data_export_actors_roles_group/fhir_resource_server_job_status_test'
require_relative 'bulk_data_export_actors_roles_group/fhir_resource_server_kickoff_request_test'
require_relative 'bulk_data_export_actors_roles_group/output_file_server_hosting_test'
require_relative 'bulk_data_export_actors_roles_group/output_file_server_returns_attachments_test'
require_relative 'bulk_data_export_actors_roles_group/output_file_server_returns_bulk_data_files_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataExportActorsRolesAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_bulk_data_export_actors_roles
      title 'Bulk Data Export Actors and Roles'

      run_as_group
      test from: :bulkdata_provider_includes_auth_server
      test from: :bulkdata_provider_includes_output_file_server
      test from: :bulkdata_provider_includes_resource_server
      test from: :bulkdata_resource_server_completion_manifest
      test from: :bulkdata_resource_server_job_status
      test from: :bulkdata_resource_server_kickoff_request
      test from: :bulkdata_output_file_server_hosting
      test from: :bulkdata_output_file_server_attachments
      test from: :bulkdata_output_file_server_bulkdata_files
    end
  end
end
