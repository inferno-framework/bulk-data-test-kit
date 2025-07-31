# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataAttachmentUrlAccessAttestationTest < Inferno::Test
      title 'Allows access to attachment URLs with/without access token as required'
      id :bulkdata_attachment_url_access
      description %(
        When the url element is populated with an absolute URL and the requiresAccessToken field in the Complete
        Status body is set to true, the url location is accessible by a client with a valid access token and does
        not require additional authentication credentials. If requiresAccessToken is false, the url location is
        accessible by a client without an access token.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@214',
                            'hl7.fhir.uv.bulkdata_2.0.0@215',
                            'hl7.fhir.uv.bulkdata_2.0.0@216'

      input :attachment_url_access_correct,
            title: %(
             Authorization, Authentication, and Security: Allows access to attachment URLs with/without access token
             as required
            ),
            description: %(
              I attest that when the url element is populated with an absolute URL and the requiresAccessToken field
              in the Complete Status body is set to true, the url location is accessible by a client with a valid
              access token and does not require additional authentication credentials. If requiresAccessToken is false,
              the url location is accessible by a client without an access token.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :attachment_url_access_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert attachment_url_access_correct == 'true',
               'Attachment URLs are not accessible as required by the specification.'
        pass attachment_url_access_note if attachment_url_access_note.present?
      end
    end
  end
end
