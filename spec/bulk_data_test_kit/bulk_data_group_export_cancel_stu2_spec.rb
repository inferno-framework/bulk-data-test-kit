# frozen_string_literal: true

require_relative '../../lib/bulk_data_test_kit/v2.0.0/group/bulk_data_group_export_cancel_group'

RSpec.describe BulkDataTestKit::BulkDataV200::BulkDataGroupExportCancelGroup do
  let(:suite_id) { 'bulk_data_v200' }
  let(:group) { Inferno::Repositories::TestGroups.new.find('bulk_data_group_export_cancel_group_stu2') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite_id) }

  describe 'Status of cancelled export test' do
    let(:url) { 'http://example.com' }

    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV200::BulkDataExportCancelTest) do
        http_client :bulk_server do
          url 'https://example.com/fhir'
        end
      end
    end

    it 'fails if a 404 is not received' do
      stub_request(:get, url)
        .to_return(status: 202)

      result = run(test_class, cancelled_polling_url: url)

      expect(result.result).to eq('fail')
      expect(result.result_message).to match(/404/)
    end

    it 'fails if an OperationOutcome is not received' do
      stub_request(:get, url)
        .to_return(status: 404, body: '{}')

      result = run(test_class, cancelled_polling_url: url)

      expect(result.result).to eq('fail')
      expect(result.result_message).to match(/OperationOutcome/)
    end

    it 'passes if a 404 and valid OperationOutcome are received' do
      stub_request(:get, url)
        .to_return(status: 404, body: FHIR::OperationOutcome.new.to_json)
      allow_any_instance_of(test_class).to receive(:assert_valid_resource).and_return(true)

      result = run(test_class, cancelled_polling_url: url)
      expect(result.result).to eq('pass')
    end
  end
end
