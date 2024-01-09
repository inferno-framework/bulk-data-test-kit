require_relative '../../export_kick_off_performer'
require_relative 'bulk_data_system_export_outputFormat_param_test.rb'
require_relative 'bulk_data_system_export_since_param_test.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemExportParameters < Inferno::TestGroup
      id :bulk_data_system_export_parameters_group
      title 'System Level Export Parameters Tests'
      description %(
        Verify that the Bulk Data server supports required query parameters for the system level export of data.
      )

      input :bearer_token,
            title: 'Bulk Data Authorization Bearer Token',
            description: 'The authorization bearer token for the Bulk FHIR server.'
      input :bulk_server_url,
            title: 'Bulk Data FHIR URL',
            description: 'The URL of the Bulk FHIR server.'

      test from: :output_format_in_export_response
      test from: :since_in_export_response
    end
  end
end
