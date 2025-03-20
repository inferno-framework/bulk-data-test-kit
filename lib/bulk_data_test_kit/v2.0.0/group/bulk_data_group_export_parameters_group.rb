# frozen_string_literal: true

require_relative '../../export_kick_off_performer'
require_relative '../bulk_data_outputFormat_param_test'
require_relative '../bulk_data_group_outputFormat_param_test'
require_relative '../bulk_data_since_param_test'
require_relative '../bulk_data_group_since_param_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportParameters < Inferno::TestGroup
      id :bulk_data_group_export_parameters_group
      title 'Group Compartment Export Parameters Tests'
      description %(
        Verify that the Bulk Data server supports required query parameters for Group export.
      )

      input :bulk_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            title: 'Bulk Data Authorization',
            description: 'The authorization information for the Bulk FHIR server. If not required, leave blank.',
            optional: true
      input :group_id,
            title: 'Group ID',
            description: 'The Group ID associated with the group of patients to be exported.'

      test from: :output_format_in_group_export_response
      test from: :since_in_group_export_response
    end
  end
end
