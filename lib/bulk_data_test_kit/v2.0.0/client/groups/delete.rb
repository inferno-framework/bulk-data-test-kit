# frozen_string_literal: true

require_relative '../export_types'
require_relative '../urls'

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

          test do
            title 'Wait For Request Sequence'

            description %(
              This test will receive bulk data export requests until the user confirms they are finished.
            )

            input :export_type, :group_id

            output :export_id

            run do
              export_id = SecureRandom.uuid

              output export_id: export_id

              wait(
                identifier: export_id,
                message: %(
                  Kick-off a #{export_type} endpoint type bulk export using the following base URL:

                  #{kickoff_url(export_id)}

                  #{export_type == GROUP_EXPORT_TYPE ? "Ensure the Group ID is set to #{group_id}." : ''}

                  Once the export request has been kicked-off,
                  [delete the export](https://build.fhir.org/ig/HL7/bulk-data/export.html#bulk-data-delete-request).

                  The entire request sequence will be recorded and used in the subsequent tests to
                  verify comformity to the
                  [Bulk Data IG](https://build.fhir.org/ig/HL7/bulk-data/export.html#sequence-overview).

                  [Click here](#{resume_pass_url}?id=#{export_id}) when finished.
                )
              )
            end
          end

          test from: :bulk_data_client_kick_off
          test from: :bulk_data_client_delete
        end
      end
    end
  end
end
