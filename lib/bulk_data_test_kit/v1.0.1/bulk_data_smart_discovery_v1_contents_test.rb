module BulkDataTestKit
  module BulkDataV101
    class BulkDataSmartDiscoveryV1ContentsTest < Inferno::Test
      title 'Well-known configuration contains the required fields'
      id :bulk_data_smart_discovery_v1_contents

      input :well_known_configuration

      run do
        status_output, bulk_download_url = check_bulk_data_output(status_response)

        output status_output:,
               bulk_download_url:
      end
    end
  end
end
