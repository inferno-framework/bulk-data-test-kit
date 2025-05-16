# frozen_string_literal: true

require_relative '../export_operation_tests'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataExportNoAuthRejectTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportOperationTests
      include BulkDataTestKit::ExportKickOffPerformer

      id :bulk_data_no_auth_reject

      title 'Bulk Data Server rejects $export request without authorization'
      description <<~DESCRIPTION
        The FHIR server SHALL limit the data returned to only those FHIR resources for which the client is authorized.

        [FHIR R4 Security](https://www.hl7.org/fhir/security.html#AccessDenied) and
        [The OAuth 2.0 Authorization Framework: Bearer Token Usage](https://tools.ietf.org/html/rfc6750#section-3.1)
        recommend using HTTP status code 401 for invalid token but also allow the actual result be controlled by policy and context.
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#bulk-data-kick-off-request'

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@9',
                            'hl7.fhir.uv.bulkdata_2.0.0@27',
                            'hl7.fhir.uv.bulkdata_2.0.0@226'

      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            optional: true

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: config.options[:resource_type],
          bulk_export_url: config.options[:bulk_export_url]
        )
      end

      run do
        rejects_without_authorization
      end
    end
  end
end
