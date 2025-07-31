# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataJwtValidationAttestationTest < Inferno::Test
      title 'Validates client authentication JWT'
      id :bulkdata_jwt_validation
      description %(
        The FHIR authorization server validates a client’s authentication JWT according to the
        client-confidential-asymmetric authentication profile and JWT validation rules, including signature,
        jti, iss, client_id, and key resolution.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@249',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@335',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@336',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@337',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@338',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@339'

      input :jwt_validation_correct,
            title: 'Authorization, Authentication, and Security: Validates client authentication JWT',
            description: %(
              I attest that the FHIR authorization server validates a client’s authentication JWT according to
              the client-confidential-asymmetric authentication profile and JWT validation rules, including signature,
              jti, iss, client_id, and key resolution.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :jwt_validation_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert jwt_validation_correct == 'true',
               'FHIR authorization server does not validate client authentication JWT as required.'
        pass jwt_validation_note if jwt_validation_note.present?
      end
    end
  end
end
