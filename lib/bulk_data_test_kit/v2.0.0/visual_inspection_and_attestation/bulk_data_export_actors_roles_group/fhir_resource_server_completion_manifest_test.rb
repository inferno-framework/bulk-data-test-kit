# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class FhirResourceServerCompletionManifestAttestationTest < Inferno::Test
      title 'Provides completion manifest'
      id :bulkdata_resource_server_completion_manifest
      description %(
        The FHIR Resource Server provides a completion manifest.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@22'

      input :resource_server_completion_manifest_correct,
            title: 'Bulk Data Export Actors and Roles: Provides completion manifest',
            description: %(
              I attest that the FHIR Resource Server provides a completion manifest.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :resource_server_completion_manifest_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert resource_server_completion_manifest_correct == 'true',
               'FHIR Resource Server does not provide a completion manifest.'
        pass resource_server_completion_manifest_note if resource_server_completion_manifest_note.present?
      end
    end
  end
end
