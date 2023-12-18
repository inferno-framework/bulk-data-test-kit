require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupExportOperationSupportTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportOperationTests

      id :bulk_data_group_export_operation_support
      title 'Bulk Data Server declares support for Group export operation in CapabilityStatement'
      description <<~DESCRIPTION
        This test verifies that the Bulk Data Server declares support for
        Group/[id]/$export operation in its server CapabilityStatement.

        Given flexibility in the FHIR specification for declaring constrained
        OperationDefinitions, this test only verifies that the server declares
        any operation on the Group resource.  It does not verify that it
        declares the standard group export OperationDefinition provided in the
        Bulk Data specification, nor does it attempt to resolve any non-standard
        OperationDefinitions to verify if it is a constrained version of the
        standard OperationDefintion.

        This test will provide a warning if no operations are declared at
        `Group/[id]/$export`, via the
        `CapabilityStatement.rest.resource.operation.name` element.  It will
        also provide an informational message if an operation on the Group
        resource exists, but does not point to the standard OperationDefinition
        canonical URL:
        http://hl7.org/fhir/uv/bulkdata/OperationDefinition/group-export

        Additionally, this test provides a warning if the bulk data server does
        not include the following URL in its `CapabilityStatement.instantiates`
        element: http://hl7.org/fhir/uv/bulkdata/CapabilityStatement/bulk-data
      DESCRIPTION

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: 'Group',
          export_operation_name: 'export'
        )
      end

      run do
        check_export_support
      end
    end
  end
end

    