# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class BulkDataClientTlsAllExchangesAttestationTest < Inferno::Test
      title 'Secures all client-server exchanges using TLS 1.2 or newer'
      id :bulkdata_client_tls_all_exchanges
      description %(
        All exchanges between the client and the server are secured using secured using Transport Layer Security
        (TLS) Protocol Version 1.2 ([RFC5246](https://tools.ietf.org/html/rfc5246)) or a more recent version of TLS.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@295',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@232'

      input :client_tls_all_exchanges_correct,
            title: 'Secures all client-server exchanges using TLS 1.2 or newer',
            description: %(
              I attest that all exchanges between the client and the server are secured using secured using Transport
              Layer Security (TLS) Protocol Version 1.2 ([RFC5246](https://tools.ietf.org/html/rfc5246)) or a more
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
      input :client_tls_all_exchanges_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_tls_all_exchanges_correct == 'true',
               'Not all client-server exchanges are secured using TLS 1.2 or newer.'
        pass client_tls_all_exchanges_note if client_tls_all_exchanges_note.present?
      end
    end
  end
end
