# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class WaitTest < Inferno::Test
      include URLs

      title 'Wait For Request Sequence'

      description %(
        This test will receive bulk data export requests until the user confirms they are finished.
      )

      id :bulk_data_client_wait

      input :access_token, :export_type, :group_id

      run do
        wait(
          identifier: access_token,
          message: %(
            Perform a **#{export_type}** endpoint type bulk export kick-off using the following base URL:

            #{fhir_url}

            #{export_type == GROUP_EXPORT_TYPE ? "Ensure the Group ID is set to **#{group_id}**." : ''}

            Include the following bearer access token with all requests: **#{access_token}**

            After the kick-off is made, a subsequent status request(s) (using the URL provided in the response
            to the kick-off request), a download request (using the URL provided in the response to
            the status request), and finally a delete request are expected.

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
