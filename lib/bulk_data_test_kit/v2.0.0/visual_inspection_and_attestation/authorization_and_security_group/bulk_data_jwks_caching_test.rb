# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataJwksCachingAttestationTest < Inferno::Test
      title 'Caches JWKS according to client cache-control'
      id :bulkdata_jwks_caching
      description %(
        The FHIR authorization server does not cache a JWKS for longer than the client’s cache-control header
        indicates and should cache a client’s JWK Set according to the client’s cache-control header.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@341',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@342'

      input :jwks_caching_correct,
            title: 'Authorization, Authentication, and Security: Caches JWKS according to client cache-control',
            description: %(
              I attest that the FHIR authorization server does not cache a JWKS for longer than the client’s
              cache-control header indicates and should cache a client’s JWK Set according to the client’s
              cache-control header.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :jwks_caching_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert jwks_caching_correct == 'true',
               'FHIR authorization server does not cache JWKS according to client cache-control.'
        pass jwks_caching_note if jwks_caching_note.present?
      end
    end
  end
end
