# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class GrantTypesSupportedAttestationTest < Inferno::Test
      title 'Includes grant_types_supported in SMART configuration metadata'
      id :bulkdata_grant_types_supported
      description %(
        The Bulk Data server's SMART configuration metadata includes the `grant_types_supported` property, listing
        supported grant types as required.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@384'

      input :grant_types_supported_correct,
            title: 'Conformance and Content Types: Includes grant_types_supported in SMART configuration metadata',
            description: %(
              I attest that the Bulk Data server's SMART configuration metadata includes the `grant_types_supported`
              property, listing supported grant types as required.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :grant_types_supported_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert grant_types_supported_correct == 'true',
               'SMART configuration metadata does not include grant_types_supported.'
        pass grant_types_supported_note if grant_types_supported_note.present?
      end
    end
  end
end
