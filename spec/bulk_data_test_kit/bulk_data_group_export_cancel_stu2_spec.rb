# frozen_string_literal: true

require_relative '../../lib/bulk_data_test_kit/v2.0.0/group/bulk_data_group_export_cancel_group'

RSpec.describe BulkDataTestKit::BulkDataV200::BulkDataGroupExportCancelGroup do
  let(:group) { Inferno::Repositories::TestGroups.new.find('bulk_data_group_export_cancel_group_stu2') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: 'bulk_data_v200') }

  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
    inputs.each do |name, value|
      session_data_repo.save(
        test_session_id: test_session.id,
        name:,
        value:,
        type: runnable.config.input_type(name)
      )
    end
    Inferno::TestRunner.new(test_session:, test_run:).run(runnable)
  end

  describe 'Status of cancelled export test' do
    let(:url) { 'http://example.com' }
    let(:group_id) { '1219' }

    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV200::BulkDataExportCancelTest) do
        http_client :bulk_server do
          url 'https://example.com/fhir'
        end

        config(
          options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
        )
      end
    end

    it 'fails if a 404 is not received' do
      stub_request(:get, url)
        .to_return(status: 202)

      result = run(test_class, group_id:, cancelled_polling_url: url)

      expect(result.result).to eq('fail')
      expect(result.result_message).to match(/404/)
    end

    it 'fails if an OperationOutcome is not received' do
      stub_request(:get, url)
        .to_return(status: 404, body: '{}')

      result = run(test_class, group_id:, cancelled_polling_url: url)

      expect(result.result).to eq('fail')
      expect(result.result_message).to match(/OperationOutcome/)
    end

    it 'passes if a 404 and valid OperationOutcome are received' do
      stub_request(:get, url)
        .to_return(status: 404, body: FHIR::OperationOutcome.new.to_json)
      allow_any_instance_of(test_class).to receive(:assert_valid_resource).and_return(true)

      result = run(test_class, group_id:, cancelled_polling_url: url)
      expect(result.result).to eq('pass')
    end
  end
end
