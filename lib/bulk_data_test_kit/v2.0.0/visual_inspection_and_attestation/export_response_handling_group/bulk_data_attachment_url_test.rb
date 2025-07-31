# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataAttachmentUrlAttestationTest < Inferno::Test
      title 'Uses absolute, dereferenceable URLs in bulk data attachments'
      id :bulkdata_attachment_url
      description %(
        When populated, the url element for attachments in the Bulk Data response is an absolute URL that can be
        dereferenced to the attachment’s content.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@213'

      input :attachment_url_correct,
            title: 'Bulk Data Export Response Handling: Uses absolute, dereferenceable URLs in bulk data attachments',
            description: %(
              I attest that when populated, the url element for attachments in the Bulk Data response is an absolute
              URL that can be dereferenced to the attachment’s content.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :attachment_url_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert attachment_url_correct == 'true',
               'Bulk Data attachments do not use absolute, dereferenceable URLs.'
        pass attachment_url_note if attachment_url_note.present?
      end
    end
  end
end
