# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class SmartClientRegistrationAttestationTest < Inferno::Test
      title 'Registers with the FHIR server'
      id :smart_client_registration
      description %(
          Before running against a FHIR server, the SMART client is registered with the server by following the
          registration steps described in client-confidential-asymmetric authentication.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@225'

      input :client_registration_correct,
            title: 'SMART Backend Services Client Registration and Discovery: Registers with the FHIR server',
            description: %(
              I attest that before running against a FHIR server, the SMART client is registered with the server
              by following the registration steps described in client-confidential-asymmetric authentication.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_registration_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_registration_correct == 'true',
               'SMART client is not registered with the FHIR server as required.'
        pass client_registration_note if client_registration_note.present?
      end
    end
  end
end
