# frozen_string_literal: true

require_relative 'patient/bulk_data_patient_export_group'
require_relative 'patient/bulk_data_patient_export_cancel_group'
require_relative 'patient/bulk_data_patient_export_validation_group'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataPatientTestGroup < Inferno::TestGroup
      title 'Bulk Data Patient API Tests'
      id :bulk_data_patient_export_v101
      run_as_group

      description %(
        The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server)
        to support required Bulk Data Patient $export operation.
      )

      group from: :bulk_data_patient_export_group
      group from: :bulk_data_patient_export_validation
      group from: :bulk_data_patient_export_cancel_group
    end
  end
end
