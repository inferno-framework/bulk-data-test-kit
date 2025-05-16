# frozen_string_literal: true

require 'tls_test_kit'
require_relative '../bulk_data_export_operation_support_test'
require_relative '../bulk_data_no_auth_test'
require_relative '../bulk_data_export_kick_off_test'
require_relative '../bulk_data_status_check_test'
require_relative '../bulk_data_output_check_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataPatientExportGroup < Inferno::TestGroup
      title 'Patient Export Tests'
      short_description 'Verify that the system supports bulk export of all Patients'
      description <<~DESCRIPTION
        Verify that patient level export on the Bulk Data server follow the Bulk Data Access Implementation Guide
      DESCRIPTION

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@225',
                            'hl7.fhir.uv.bulkdata_2.0.0@272'

      id :bulk_data_patient_export_group

      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            title: 'Bulk Data Authorization',
            description: 'The authorization information for the Bulk FHIR server. If not required, leave access token blank.',
            optional: true
      input :bulk_timeout,
            title: 'Export Times Out after (1-600)',
            description: <<~DESCRIPTION,
              While testing, Inferno waits for the server to complete the exporting task. If the calculated totalTime is
              greater than the timeout value specified here, Inferno bulk client stops testing. Please enter an integer
              for the maximum wait time in seconds. If timeout is less than 1, Inferno uses default value 180. If the
                timeout is greater than 600 (10 minutes), Inferno uses the maximum value 600.
            DESCRIPTION
            default: 180

      output :patient_requires_access_token, :patient_status_output, :patient_bulk_download_url

      test from: :bulk_data_export_operation_support do
        title 'Bulk Data Server declares support for Patient export operation in CapabilityStatement'
        description <<~DESCRIPTION
          This test verifies that the Bulk Data Server declares support for
          `Patient/$export` operation in its server CapabilityStatement.

          Given flexibility in the FHIR specification for declaring constrained
          OperationDefinitions, this test only verifies that the server declares
          any operation on the Patient resource.  It does not verify that it
          declares the standard Patient export OperationDefinition provided in the
          Bulk Data specification, nor does it attempt to resolve any non-standard
          OperationDefinitions to verify if it is a constrained version of the
          standard OperationDefintion.

          This test will provide a warning if no operations are declared at
          `Patient/$export`, via the
          `CapabilityStatement.rest.resource.operation.name` element.  It will
          also provide an informational message if an operation on the Patient
          resource exists, but does not point to the standard OperationDefinition
          canonical URL:
          http://hl7.org/fhir/uv/bulkdata/OperationDefinition/patient-export

          Additionally, this test provides a warning if the bulk data server does
          not include the following URL in its `CapabilityStatement.instantiates`
          element: http://hl7.org/fhir/uv/bulkdata/CapabilityStatement/bulk-data
        DESCRIPTION
        id :bulk_data_patient_export_operation_support

        config(
          options: { resource_type: 'Patient' }
        )
      end

      test from: :bulk_data_no_auth_reject,
           id: :bulk_data_patient_no_auth_reject,
           config: {
             options: { resource_type: 'Patient', bulk_export_url: 'Patient/$export' }
           }

      test from: :bulk_data_kick_off,
           id: :bulk_data_patient_kick_off,
           config: {
             outputs: { polling_url: { name: :patient_polling_url } },
             options: { resource_type: 'Patient', bulk_export_url: 'Patient/$export' }
           }

      test from: :bulk_data_status_check,
           id: :bulk_data_patient_status_check,
           config: {
             inputs: { polling_url: { name: :patient_polling_url } },
             outputs: {
               status_response: { name: :patient_status_response },
               requires_access_token: { name: :patient_requires_access_token }
             },
             options: { resource_type: 'Patient' }
           }

      test from: :bulk_data_output_check,
           id: :bulk_data_patient_output_check,
           config: {
             inputs: { status_response: { name: :patient_status_response } },
             outputs: {
               status_output: { name: :patient_status_output },
               bulk_download_url: { name: :patient_bulk_download_url }
             },
             options: { resource_type: 'Patient' }
           }
    end
  end
end
