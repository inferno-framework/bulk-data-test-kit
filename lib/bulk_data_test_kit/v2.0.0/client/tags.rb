# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    module Client
      # Tags for use in Bulk Data Client tests and endpoints
      module Tags
        METADATA_TAG = 'metadata_req'
        PATIENT_KICKOFF_TAG = 'kickoff_patient_req'
        GROUP_KICKOFF_TAG = 'kickoff_group_req'
        SYSTEM_KICKOFF_TAG = 'kickoff_system_req'
        STATUS_TAG = 'status_req'
        OUTPUT_TAG = 'output_req'
        DELETE_TAG = 'delete_req'
      end
    end
  end
end
