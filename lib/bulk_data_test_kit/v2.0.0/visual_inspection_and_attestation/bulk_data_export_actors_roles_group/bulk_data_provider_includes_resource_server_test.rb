# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataProviderIncludesResourceServerAttestationTest < Inferno::Test
      title 'Includes a FHIR Resource Server'
      id :bulkdata_provider_includes_resource_server
      description %(
        The Bulk Data Provider consists of a FHIR Resource Server.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@13'

      input :provider_includes_resource_server_correct,
            title: 'Bulk Data Export Actors and Roles: Includes a FHIR Resource Server',
            description: %(
              I attest that the Bulk Data Provider consists of a FHIR Resource Server.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :provider_includes_resource_server_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert provider_includes_resource_server_correct == 'true',
               'Bulk Data Provider does not include a FHIR Resource Server.'
        pass provider_includes_resource_server_note if provider_includes_resource_server_note.present?
      end
    end
  end
end
