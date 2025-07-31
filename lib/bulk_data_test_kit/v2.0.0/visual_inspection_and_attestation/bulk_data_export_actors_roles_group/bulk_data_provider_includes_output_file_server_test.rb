# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataProviderIncludesOutputFileServerAttestationTest < Inferno::Test
      title 'Includes an Output File Server'
      id :bulkdata_provider_includes_output_file_server
      description %(
        The Bulk Data Provider consists of an Output File Server.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@14'

      input :provider_includes_output_file_server_correct,
            title: 'Bulk Data Export Actors and Roles: Includes an Output File Server',
            description: %(
              I attest that the Bulk Data Provider consists of an Output File Server.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :provider_includes_output_file_server_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert provider_includes_output_file_server_correct == 'true',
               'Bulk Data Provider does not include an Output File Server.'
        pass provider_includes_output_file_server_note if provider_includes_output_file_server_note.present?
      end
    end
  end
end
