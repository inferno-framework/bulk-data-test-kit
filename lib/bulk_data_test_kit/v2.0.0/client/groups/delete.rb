# frozen_string_literal: true

require_relative '../export_types'
require_relative '../urls'

require_relative '../tests/delete_wait'
require_relative '../tests/kick_off'
require_relative '../tests/delete'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Groups
        # Bulk Data Client Delete Tests
        class Delete < Inferno::TestGroup
          include ExportTypes
          include URLs

          title 'Bulk Data Client Delete Tests'

          description %(
            The Bulk Data Client Delete tests verify the ability of a client to delete
            a kicked-off bulk data export request.
          )

          id :bulk_data_client_delete_group

          run_as_group

          input :export_type,
                title: 'Export Type',
                description: 'The export endpoint type to test against.',
                type: 'radio',
                default: SYSTEM_EXPORT_TYPE,
                options: {
                  list_options: [
                    {
                      label: 'All Patients',
                      value: PATIENT_EXPORT_TYPE
                    },
                    {
                      label: 'Group of Patients',
                      value: GROUP_EXPORT_TYPE
                    },
                    {
                      label: 'System Level Export',
                      value: SYSTEM_EXPORT_TYPE
                    }
                  ]
                }

          input :group_id,
                title: 'Group ID',
                description: 'If using the Group endpoint, the identifier of the Group to export.',
                default: 1,
                locked: true

          test from: :bulk_data_client_delete_wait
          test from: :bulk_data_client_kick_off
          test from: :bulk_data_client_kick_off
          test from: :bulk_data_client_delete
        end
      end
    end
  end
end
