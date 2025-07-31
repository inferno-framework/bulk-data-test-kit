# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class SmartClientRetrieveConfigurationFileAttestationTest < Inferno::Test
      title 'Retrieves SMART configuration file via HTTP GET'
      id :smart_client_retrieve_configuration_file
      description %(
        The SMART client issues an HTTP GET with an Accept header supporting application/json to retrieve the SMART
        configuration file from [base]/.well-known/smart-configuration.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@227'

      input :client_retrieve_configuration_file_correct,
            title: %(
             SMART Backend Services Client Registration and Discovery: Retrieves SMART configuration file via HTTP GET
            ),
            description: %(
              I attest that the SMART client issues an HTTP GET with an Accept header supporting application/json to
              retrieve the SMART configuration file from [base]/.well-known/smart-configuration.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_retrieve_configuration_file_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_retrieve_configuration_file_correct == 'true',
               'SMART client does not retrieve SMART configuration file via HTTP GET as required.'
        pass client_retrieve_configuration_file_note if client_retrieve_configuration_file_note.present?
      end
    end
  end
end
