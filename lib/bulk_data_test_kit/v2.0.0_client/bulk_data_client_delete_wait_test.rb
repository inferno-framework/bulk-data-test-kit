# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    # Bulk Data Client - Delete Wait
    class DeleteWaitTest < Inferno::Test
      include URLs

      title 'Wait For Request Sequence'

      description %(
        This test will receive bulk data export requests until the user confirms they are finished.
      )

      id :bulk_data_client_delete_wait

      input :access_token, :export_type, :group_id

      run do
        wait(
          identifier: access_token,
          message: %(
            Kick-off a **#{export_type}** endpoint type bulk export using the following base URL:

            #{kickoff_url}

            #{export_type == GROUP_EXPORT_TYPE ? "Ensure the Group ID is set to **#{group_id}**." : ''}

            Include the following bearer access token with all requests: **#{access_token}**

            Once the export request has been kicked-off,
            [delete the export](https://build.fhir.org/ig/HL7/bulk-data/export.html#bulk-data-delete-request).

            The entire request sequence will be recorded and used in the subsequent tests to
            verify comformity to the
            [Bulk Data IG](https://build.fhir.org/ig/HL7/bulk-data/export.html#sequence-overview).

            [Click here](#{resume_pass_url}?id=#{access_token}) when finished.
          )
        )
      end
    end
  end
end
