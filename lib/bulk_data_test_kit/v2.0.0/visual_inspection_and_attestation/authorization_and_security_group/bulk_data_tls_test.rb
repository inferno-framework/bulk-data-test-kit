# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataTLSAttestationTest < Inferno::Test
      title 'Ensures all exchanges are secured using TLS v1.2 or newer'
      id :bulkdata_tls
      description %(
        All exchanges between the client and the FHIR server are secured using TLS v1.2 or a more recent version of
        TLS.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@231'

      input :tls_correct,
            title: %(
              Authorization, Authentication, and Security: Ensures all exchanges are secured using TLS v1.2 or newer
            ),
            description: %(
              I attest that all exchanges between the client and the FHIR server are secured using TLS v1.2 or a more
              recent version of TLS.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :tls_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert tls_correct == 'true',
               'Not all exchanges are secured using TLS v1.2 or newer.'
        pass tls_note if tls_note.present?
      end
    end
  end
end
