module BulkDataTestKit
  class Metadata < Inferno::TestKit
    id :bulk_data_test_kit
    title 'Bulk Data Test Kit'
    suite_ids []
    tags []
    last_updated ::BulkDataTestKit::LAST_UPDATED
    version ::BulkDataTestKit::VERSION
    maturity ''
    authors []
    repo 'https://github.com/inferno-framework/bulk-data-test-kit'
    description <<~DESCRIPTION
      This is a big markdown description of the test kit.
    DESCRIPTION
  end
end
