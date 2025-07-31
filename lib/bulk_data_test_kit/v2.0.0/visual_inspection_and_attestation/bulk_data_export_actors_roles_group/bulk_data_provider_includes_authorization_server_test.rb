# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataProviderIncludesAuthorizationServerAttestationTest < Inferno::Test
      title 'Includes a FHIR Authorization Server'
      id :bulkdata_provider_includes_auth_server
      description %(
        The Bulk Data Provider consists of a FHIR Authorization Server.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@12'

      input :provider_includes_authz_server_correct,
            title: 'Bulk Data Export Actors and Roles: Includes a FHIR Authorization Server',
            description: %(
              I attest that the Bulk Data Provider consists of a FHIR Authorization Server.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :provider_includes_authz_server_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert provider_includes_authz_server_correct == 'true',
               'Bulk Data Provider does not include a FHIR Authorization Server.'
        pass provider_includes_authz_server_note if provider_includes_authz_server_note.present?
      end
    end
  end
end
