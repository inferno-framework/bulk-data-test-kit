require_relative '../../export_kick_off_performer'
require_relative 'bulk_data_patient_export_cancel_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataPatientExportCancelGroup < Inferno::TestGroup
      id :bulk_data_patient_export_cancel_group
      title 'Patient Export Cancel Tests'
      description %(
        Verify that the Bulk Data server supports cancelling requested exports of all Patients.
        This group initiates a new export and immediately cancels it to verify
        correct behavior.
      )

      input :bearer_token
      input :bulk_server_url,
            title: 'Bulk Data FHIR URL',
            description: 'The URL of the Bulk FHIR server.'

      test from: :bulk_data_patient_export_cancel
    end
  end
end
