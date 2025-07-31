# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class BulkDataClientAccessTokenForFileRequestAttestationTest < Inferno::Test
      title 'Includes access token when required'
      id :bulkdata_client_access_token_for_file_request
      description %(
        If the requiresAccessToken field in the Complete Status body is set to true, the Bulk Data Client includes
        a valid access token in the request for Bulk Data files.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@201'

      input :client_access_token_for_file_request_correct,
            title: 'Bulk Data Client Role and Data Retrieval: Includes access token when required',
            description: %(
              I attest that if the requiresAccessToken field in the Complete Status body is set to true, the Bulk
              Data Client includes a valid access token in the request for Bulk Data files.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_access_token_for_file_request_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_access_token_for_file_request_correct == 'true',
               'Bulk Data Client does not include a valid access token when required.'
        pass client_access_token_for_file_request_note if client_access_token_for_file_request_note.present?
      end
    end
  end
end
