require_relative '../../export_kick_off_performer'
require_relative '../bulk_data_outputFormat_param_test.rb'
require_relative '../bulk_data_since_param_test.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientExportParameters < Inferno::TestGroup
      id :bulk_data_patient_export_parameters_group
      title 'Patient Export Parameters Tests'
      description %(
        Verify that the Bulk Data server supports required query parameters for the export of all Patient resources.
      )

      input :bearer_token,
            title: 'Bulk Data Authorization Bearer Token',
            description: 'The authorization bearer token for the Bulk FHIR server. If not required, leave blank.',
            optional: true
      input :bulk_server_url,
            title: 'Bulk Data FHIR URL',
            description: 'The URL of the Bulk FHIR server.'

      test from: :output_format_in_export_response,
        id: :output_format_in_patient_export_response,
        config: {
          options: { resource_type: 'Patient', bulk_export_url: 'Patient/$export' }
        }
          
      test from: :since_in_export_response,
        id: :since_in_patient_export_response,
        config: {
          options: { resource_type: 'Patient', bulk_export_url: 'Patient/$export' }
        }
    end
  end
end
