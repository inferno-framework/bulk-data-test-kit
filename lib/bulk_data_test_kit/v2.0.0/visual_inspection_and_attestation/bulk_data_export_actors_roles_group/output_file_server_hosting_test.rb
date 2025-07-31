# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class OutputFileServerHostingAttestationTest < Inferno::Test
      title 'Allows for output File Server to be built into the FHIR Server or independently hosted'
      id :bulkdata_output_file_server_hosting
      description %(
        The Output File Server may be built into the FHIR Server, or may be independently hosted.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@25'

      input :output_file_server_hosting_correct,
            title: %(
              Bulk Data Export Actors and Roles: Allows for output File Server to be built into the FHIR Server or
              independently hosted
            ),
            description: %(
              I attest that the Output File Server may be built into the FHIR Server, or may be independently hosted.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :output_file_server_hosting_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert output_file_server_hosting_correct == 'true',
               'Output File Server is not hosted as required.'
        pass output_file_server_hosting_note if output_file_server_hosting_note.present?
      end
    end
  end
end
