# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSmartSymmetricProfileNotUsedAttestationTest < Inferno::Test
      title 'Utilizes a different profile than SMART client-confidential-symmetric profile for Backend Services'
      id :bulkdata_smart_symmetric_profile_not_used
      description %(
        The SMART client-confidential-symmetric profile is not used for SMART Backend Services clients.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@344'

      input :smart_symmetric_profile_not_used_correct,
            title: %(
             Authorization, Authentication, and Security: Utilizes a different profile than SMART
             client-confidential-symmetric profile for Backend Services
            ),
            description: %(
              I attest that the SMART client-confidential-symmetric profile is not used for SMART Backend Services
              clients.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :smart_symmetric_profile_not_used_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert smart_symmetric_profile_not_used_correct == 'true',
               'SMART client-confidential-symmetric profile is used for Backend Services clients.'
        pass smart_symmetric_profile_not_used_note if smart_symmetric_profile_not_used_note.present?
      end
    end
  end
end
