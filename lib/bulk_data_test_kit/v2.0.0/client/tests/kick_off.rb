# frozen_string_literal: true

require_relative '../tags'
require_relative '../urls'
require_relative '../export_types'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Tests
        # Bulk Data Client Kick-off
        class KickOff < Inferno::Test
          include Tags
          include URLs
          include ExportTypes

          PATIENT_FAIL = 'Did not receive a Patient type kick-off request.'
          GROUP_FAIL = 'Did not receive a Group type kick-off request.'
          SYSTEM_FAIL = 'Did not receive a System type kick-off request.'

          title 'Bulk Data Kick-off Request'

          description %(
            This test verifies that a client can
            [kick-off a Bulk Data request](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#roles)
            using the `$export` operation against the proper endpoint type.
          )

          id :bulk_data_client_kick_off

          verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@17'

          input :export_id, :export_type, :group_id

          run do
            case export_type
            when PATIENT_EXPORT_TYPE
              assert load_tagged_requests(PATIENT_KICKOFF_TAG).any?, PATIENT_FAIL
            when GROUP_EXPORT_TYPE
              assert load_tagged_requests(GROUP_KICKOFF_TAG).any?, GROUP_FAIL
            when SYSTEM_EXPORT_TYPE
              assert load_tagged_requests(SYSTEM_KICKOFF_TAG).any?, SYSTEM_FAIL
            end
          end
        end
      end
    end
  end
end
