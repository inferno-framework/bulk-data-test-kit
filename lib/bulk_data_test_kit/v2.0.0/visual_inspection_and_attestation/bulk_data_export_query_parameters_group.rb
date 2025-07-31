# frozen_string_literal: true

require_relative 'bulk_data_export_query_parameters_group/elements_parameter_test'
require_relative 'bulk_data_export_query_parameters_group/include_associated_data_parameter_test'
require_relative 'bulk_data_export_query_parameters_group/patient_parameter_test'
require_relative 'bulk_data_export_query_parameters_group/provenance_associated_data_test'
require_relative 'bulk_data_export_query_parameters_group/since_parameter_test'
require_relative 'bulk_data_export_query_parameters_group/type_filter_parameter_test'
require_relative 'bulk_data_export_query_parameters_group/type_parameter_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataExportQueryParametersAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_bulk_data_export_query_parameters
      title 'Bulk Data Export Query Parameters'

      run_as_group
      test from: :bulkdata_elements_parameter
      test from: :bulkdata_include_associated_data_parameter
      test from: :bulkdata_patient_parameter
      test from: :bulkdata_provenance_associated_data
      test from: :bulkdata_since_parameter
      test from: :bulkdata_type_filter_parameter
      test from: :bulkdata_type_parameter
    end
  end
end
