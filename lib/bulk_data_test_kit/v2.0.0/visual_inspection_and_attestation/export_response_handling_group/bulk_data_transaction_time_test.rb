# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataTransactionTimeAttestationTest < Inferno::Test
      title 'Includes resources modified up to transactionTime'
      id :bulkdata_transaction_time
      description %(
        The Bulk Data response includes any matching resources modified up to and including the transactionTime
        instant.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@154'

      input :transaction_time_correct,
            title: 'Bulk Data Export Response Handling: Includes resources modified up to transactionTime',
            description: %(
              I attest that the Bulk Data response includes any matching resources modified up to and including the
              transactionTime instant.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :transaction_time_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert transaction_time_correct == 'true',
               'Bulk Data response does not include resources modified up to transactionTime.'
        pass transaction_time_note if transaction_time_note.present?
      end
    end
  end
end
