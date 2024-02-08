require_relative 'export_kick_off_performer'
require_relative 'bulk_data_test_kit_properties'

module BulkDataTestKit
  module BulkDataExportParametersTests
    extend Forwardable
   
    def_delegators 'self.class', :properties
    def_delegators 'properties',
                   :resource_type,
                   :bulk_export_url


    def perform_outputFormat_param_test
      url = bulk_export_url.dup
      if resource_type == 'Group'
        url = bulk_export_url.gsub('[group_id]', group_id)
      end

      ['application/fhir+ndjson', 'application/ndjson', 'ndjson'].each do |format|
        kickoff_url = url.dup
        perform_export_kick_off_request(params: { _outputFormat: format }, url: kickoff_url)
        assert_response_status(202)

        delete_export_kick_off_request
      end
    end

    def perform_since_param_test(since_timestamp_param)
      fhir_instant_regex = /
        ([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)
        -(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])
        T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\.[0-9]+)
        ?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))
      /x

      url = bulk_export_url.dup
      if resource_type == 'Group'
        url = bulk_export_url.gsub('[group_id]', group_id)
      end

      assert since_timestamp_param.match?(fhir_instant_regex),
            "The provided `_since` timestamp `#{since_timestamp_param}` is not a valid " \
            '[FHIR instant](https://www.hl7.org/fhir/datatypes.html#instant).'

      perform_export_kick_off_request(params: { _since: since_timestamp_param }, url: url)
      assert_response_status(202)

      delete_export_kick_off_request
    end
  end
end