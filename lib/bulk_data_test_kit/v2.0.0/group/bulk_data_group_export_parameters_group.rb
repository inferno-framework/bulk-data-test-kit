# frozen_string_literal: true

require_relative '../../export_kick_off_performer'
require_relative '../bulk_data_outputFormat_param_test'
require_relative '../bulk_data_since_param_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportParameters < Inferno::TestGroup
      id :bulk_data_group_export_parameters_group
      title 'Group Compartment Export Parameters Tests'
      description %(
        Verify that the Bulk Data server supports required query parameters for Group export.
      )

      input :bearer_token,
            title: 'Bulk Data Authorization Bearer Token',
            description: 'The authorization bearer token for the Bulk FHIR server. If not required, leave blank.',
            optional: true
      input :bulk_server_url,
            title: 'Bulk Data FHIR URL',
            description: 'The URL of the Bulk FHIR server.'
      input :group_id,
            title: 'Group ID',
            description: 'The Group ID associated with the group of patients to be exported.'

      test from: :output_format_in_export_response,
           id: :output_format_in_group_export_response,
           config: {
             options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
           }

      test from: :since_in_export_response,
           id: :since_in_group_export_response,
           config: {
             options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
           }
    end
  end
end
