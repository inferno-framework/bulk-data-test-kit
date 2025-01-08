# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    # Bulk Data Client Kick-off
    class KickOffTest < Inferno::Test
      include Tags
      include ExportTypes

      title 'Bulk Data Kick-off Request'

      description %(
        This test verifies that a client can
        [kick-off a Bulk Data request](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#roles)
        using the `$export` operation against the proper endpoint type.
      )

      id :bulk_data_client_kick_off

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@17'

      input :export_type

      run do
        case export_type
        when PATIENT_EXPORT_TYPE
          assert load_tagged_requests(PATIENT_KICKOFF_TAG).any?, patient_fail_message
        when GROUP_EXPORT_TYPE
          assert load_tagged_requests(GROUP_KICKOFF_TAG).any?, group_fail_message
        when SYSTEM_EXPORT_TYPE
          assert load_tagged_requests(SYSTEM_KICKOFF_TAG).any?, system_fail_message
        end
      end

      def patient_fail_message
        'Did not receive a Patient type kick-off request.'
      end

      def group_fail_message
        'Did not receive a Group type kick-off request.'
      end

      def system_fail_message
        'Did not receive a System type kick-off request.'
      end
    end
  end
end
