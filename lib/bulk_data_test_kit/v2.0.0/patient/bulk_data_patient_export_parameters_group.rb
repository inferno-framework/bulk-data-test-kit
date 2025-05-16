# frozen_string_literal: true

require_relative '../../export_kick_off_performer'
require_relative '../bulk_data_outputFormat_param_test'
require_relative '../bulk_data_since_param_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientExportParameters < Inferno::TestGroup
      id :bulk_data_patient_export_parameters_group
      title 'Patient Export Parameters Tests'
      description %(
        Verify that the Bulk Data server supports required query parameters for the export of all Patient resources.
      )

      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            title: 'Bulk Data Authorization',
            description: 'The authorization information for the Bulk FHIR server. If not required, leave blank.',
            optional: true

      test from: :output_format_in_export_response,
           id: :output_format_in_patient_export_response,
           config: {
             options: { resource_type: 'Patient', bulk_export_url: 'Patient/$export' }
           },
           verifies_requirements: ['hl7.fhir.uv.bulkdata_2.0.0@274']

      test from: :since_in_export_response,
           id: :since_in_patient_export_response,
           config: {
             options: { resource_type: 'Patient', bulk_export_url: 'Patient/$export' }
           }
    end
  end
end
