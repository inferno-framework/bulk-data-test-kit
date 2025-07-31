# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class JsonMimeTypeAttestationTest < Inferno::Test
      title 'Returns JSON using application/json mime type'
      id :bulkdata_json_mime_type
      description %(
        The Bulk Data server returns JSON documents using the `application/json` mime type, as required by the
        specification.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@380'

      input :json_mime_type_correct,
            title: 'Conformance and Content Types: Returns JSON using application/json mime type',
            description: %(
              I attest that the Bulk Data server returns JSON documents using the `application/json` mime type, as
              required by the specification.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :json_mime_type_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert json_mime_type_correct == 'true',
               'Bulk Data server does not return JSON using application/json mime type.'
        pass json_mime_type_note if json_mime_type_note.present?
      end
    end
  end
end
