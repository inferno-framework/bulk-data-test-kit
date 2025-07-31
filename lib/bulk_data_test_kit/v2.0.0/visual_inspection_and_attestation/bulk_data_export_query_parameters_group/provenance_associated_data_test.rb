# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class ProvenanceAssociatedDataAttestationTest < Inferno::Test
      title 'Handles Bulk Data includeAssociatedData Provenance values correctly'
      id :bulkdata_provenance_associated_data
      description %(
        When `includeAssociatedData`:
        - Is set to `LatestProvenanceResources`, only the most recent Provenance resources associated with each
          non-provenance resource are included.
        - Is set to `RelevantProvenanceResources`, all associated Provenance resources are included.
        - Is not specified or not supported, all available Provenance resources whose Provenance.target is a
          resource in the Patient compartment (for patient-level export) or all available Provenance resources
          (for system-level export) are included unless _type excludes Provenance.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@97',
                            'hl7.fhir.uv.bulkdata_2.0.0@98',
                            'hl7.fhir.uv.bulkdata_2.0.0@99',
                            'hl7.fhir.uv.bulkdata_2.0.0@109',
                            'hl7.fhir.uv.bulkdata_2.0.0@110',
                            'hl7.fhir.uv.bulkdata_2.0.0@111',
                            'hl7.fhir.uv.bulkdata_2.0.0@112'

      input :provenance_associated_data_correct,
            title: %(
              Bulk Data Export Query Parameters: Handles Bulk Data includeAssociatedData Provenance values correctly
            ),
            description: %(
              I attest that when `includeAssociatedData`:
              - Is set to `LatestProvenanceResources`, only the most recent Provenance resources associated with each
                non-provenance resource are included.
              - Is set to `RelevantProvenanceResources`, all associated Provenance resources are included.
              - Is not specified or not supported, all available Provenance resources whose Provenance.target is a
                resource in the Patient compartment (for patient-level export) or all available Provenance resources
                (for system-level export) are included unless _type excludes Provenance.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :provenance_associated_data_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert provenance_associated_data_correct == 'true',
               'Bulk Data includeAssociatedData Provenance values are not handled as required.'
        pass provenance_associated_data_note if provenance_associated_data_note.present?
      end
    end
  end
end
