# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class SmartClientDiscoverConfigurationAttestationTest < Inferno::Test
      title 'Discovers FHIR server’s SMART configuration metadata'
      id :smart_client_discover_configuration
      description %(
        The SMART client discovers the EHR FHIR server’s SMART configuration metadata, including OAuth token endpoint
        URL.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@226'

      input :client_discover_configuration_correct,
            title: %(
             SMART Backend Services Client Registration and Discovery: Discovers FHIR server’s SMART configuration
             metadata
            ),
            description: %(
              I attest that the SMART client discovers the EHR FHIR server’s SMART configuration metadata, including
              OAuth token endpoint URL.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_discover_configuration_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_discover_configuration_correct == 'true',
               'SMART client does not discover FHIR server’s SMART configuration metadata as required.'
        pass client_discover_configuration_note if client_discover_configuration_note.present?
      end
    end
  end
end
