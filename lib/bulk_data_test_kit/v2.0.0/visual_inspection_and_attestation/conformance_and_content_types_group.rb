# frozen_string_literal: true

require_relative 'conformance_and_content_types_group/comma_delimited_parameters_test'
require_relative 'conformance_and_content_types_group/grant_types_supported_test'
require_relative 'conformance_and_content_types_group/json_mime_type_test'

module BulkDataTestKit
  module BulkDataV200
    class ConformanceAndContentTypesAttestationGroup < Inferno::TestGroup
      id :bulk_data_v200_conformance_and_content_types
      title 'Conformance and Content Types'

      run_as_group
      test from: :bulkdata_comma_delimited_parameters
      test from: :bulkdata_grant_types_supported
      test from: :bulkdata_json_mime_type
    end
  end
end
