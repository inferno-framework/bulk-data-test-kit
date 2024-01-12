require_relative '../../v1.0.1/patient/bulk_data_patient_export_cancel_group'
require_relative '../bulk_data_export_cancel_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientExportCancelGroup < BulkDataV101::BulkDataPatientExportCancelGroup
      id :bulk_data_patient_export_cancel_group_stu2

      test from: :bulk_data_export_cancel_stu2,
        id: :bulk_data_patient_export_cancel_stu2,
        config: {
          inputs: { cancelled_polling_url: { name: :patient_cancelled_polling_url } },
        }

    end
  end
end
