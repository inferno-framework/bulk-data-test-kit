# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataJwkRegistrationAttestationTest < Inferno::Test
      title 'Supports client JWK registration and protection'
      id :bulkdata_jwk_registration
      description %(
        The FHIR authorization server supports registration of client JWKs using a URL to a JWK set or a JWK Set
        directly, protects the JWK Set from corruption, is capable of validating signatures with at least one
        of RS384 or ES384, and assigns a client_id upon registration.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@296',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@297',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@305',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@310',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@316'

      input :jwk_registration_correct,
            title: 'Authorization, Authentication, and Security: Supports client JWK registration and protection',
            description: %(
              I attest that the FHIR authorization server supports registration of client JWKs using a URL to a JWK
              set or a JWK Set directly, protects the JWK Set from corruption, is capable of validating signatures
              with at least one of RS384 or ES384, and assigns a client_id upon registration.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :jwk_registration_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert jwk_registration_correct == 'true',
               'FHIR authorization server does not support client JWK registration and protection as required.'
        pass jwk_registration_note if jwk_registration_note.present?
      end
    end
  end
end
