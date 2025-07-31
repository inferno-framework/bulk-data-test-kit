# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientGeneratesOrObtainsAsymmetricKeyPairAttestationTest < Inferno::Test
      title 'Generates or obtains an asymmetric key pair'
      id :client_generates_or_obtains_asymmetric_key_pair
      description %(
        Before running against a FHIR server, the client generates or obtains an asymmetric key pair.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@290'

      input :client_generates_or_obtains_asymmetric_key_pair_correct,
            title: 'Client Key Management & JWK Registration: Generates or obtains an asymmetric key pair',
            description: %(
              I attest that before running against a FHIR server, the client generates or obtains an asymmetric key
              pair.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_generates_or_obtains_asymmetric_key_pair_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_generates_or_obtains_asymmetric_key_pair_correct == 'true',
               'Client does not generate or obtain an asymmetric key pair as required.'
        if client_generates_or_obtains_asymmetric_key_pair_note.present?
          pass client_generates_or_obtains_asymmetric_key_pair_note
        end
      end
    end
  end
end
