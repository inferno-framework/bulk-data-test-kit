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

      input :client_id,
          title: 'Client Id',
          type: 'text',
          optional: true,
          locked: true,
          description: SMARTAppLaunch::INPUT_CLIENT_ID_DESCRIPTION_LOCKED
      input :export_type, :group_id

      run do
        wait(
          identifier: client_id,
          message: %(
            Perform a **#{export_type}** endpoint type bulk export kick-off using the following base URL:

            #{fhir_url}

            #{export_type == GROUP_EXPORT_TYPE ? "Ensure the Group ID is set to **#{group_id}**." : ''}

            Use client id `#{client_id} to obtain a backend services access token from the SMART authorization
            server for this FHIR server and include the access token on all subsequent requests.

            After the kick-off is made, subsequent status request(s) (using the URL provided in the response
            to the kick-off request), a download request (using the URL provided in the response to
            the status request), and finally a delete request are expected.

            The entire request sequence will be recorded and verified to check conformance to the
            [Bulk Data IG](https://build.fhir.org/ig/HL7/bulk-data/export.html#sequence-overview).

            [Click here](#{resume_pass_url}?id=#{client_id}) when finished.
          ),
          timeout: 900
        )
      end
    end
  end
end
