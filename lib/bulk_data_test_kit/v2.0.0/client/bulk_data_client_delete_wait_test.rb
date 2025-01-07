# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    module Client
      # Bulk Data Client - Delete Wait
      class DeleteWaitTest < Inferno::Test
        include URLs
        include ExportTypes

        title 'Wait For Request Sequence'

        description %(
          This test will receive bulk data export requests until the user confirms they are finished.
        )

        id :bulk_data_client_delete_wait

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
    end
  end
end
