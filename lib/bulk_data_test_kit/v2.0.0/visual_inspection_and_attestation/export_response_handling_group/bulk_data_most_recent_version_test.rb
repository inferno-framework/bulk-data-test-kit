# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataMostRecentVersionAttestationTest < Inferno::Test
      title 'Includes only the most recent version of resources'
      id :bulkdata_most_recent_version
      description %(
        The exported data includes only the most recent version of any exported resources unless the client explicitly
        requests different behavior in a fashion supported by the server.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@202'

      input :most_recent_version_correct,
            title: 'Bulk Data Export Response Handling: Includes only the most recent version of resources',
            description: %(
              I attest that the exported data includes only the most recent version of any exported resources unless
              the client explicitly requests different behavior in a fashion supported by the server.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :most_recent_version_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert most_recent_version_correct == 'true',
               'Bulk Data export does not include only the most recent version of resources.'
        pass most_recent_version_note if most_recent_version_note.present?
      end
    end
  end
end
