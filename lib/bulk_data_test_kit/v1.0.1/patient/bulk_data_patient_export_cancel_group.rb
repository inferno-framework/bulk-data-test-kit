# frozen_string_literal: true

require_relative '../../export_kick_off_performer'
require_relative '../bulk_data_export_cancel_test'

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

      input :bulk_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            optional: true

      output :patient_cancelled_polling_url

      test from: :bulk_data_export_cancel,
           id: :bulk_data_patient_export_cancel,
           config: {
             outputs: { cancelled_polling_url: { name: :patient_cancelled_polling_url } },
             options: { resource_type: 'Patient', bulk_export_url: 'Patient/$export' }
           }
    end
  end
end
