# frozen_string_literal: true

require_relative '../../lib/bulk_data_test_kit/v1.0.1/group/bulk_data_group_export_cancel_group'

RSpec.describe BulkDataTestKit::BulkDataV101::BulkDataGroupExportCancelGroup do
  let(:group) { Inferno::Repositories::TestGroups.new.find('bulk_data_group_export_cancel_group') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: 'bulk_data_v101') }
  let(:bulk_server_url) { 'https://example.com/fhir' }
  let(:bearer_token) { 'some_bearer_token_alphanumeric' }
  let(:group_id) { '1219' }
  let(:polling_url) { 'https://redirect.com' }
  let(:base_input) do
    {
      bulk_server_url:,
      bearer_token:,
      group_id:
    }
  end

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

  describe 'delete request tests' do
    let(:bulk_export_url) { "#{bulk_server_url}/Group/1219/$export" }

    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV101::BulkDataExportCancelTest) do
        http_client :bulk_server do
          url :bulk_server_url
        end

        input :bulk_server_url, :group_id
        input :bearer_token, optional: true
        config(
          options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
        )
      end
    end

    it 'passes when no Bearer Token is given' do
      stub_request(:get, bulk_export_url)
        .to_return(status: 202, headers: { 'content-location': polling_url })
      stub_request(:delete, polling_url)
        .to_return(status: 202)

      base_input[:bearer_token] = nil
      result = run(test_class, base_input)
      expect(result.result).to eq('pass')
    end

    it 'fails when unable to kick-off export' do
      stub_request(:get, bulk_export_url)
        .to_return(status: 404)

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 202, but received 404')
    end

    it 'fails when content-location header not provided in kick-off response' do
      stub_request(:get, bulk_export_url)
        .to_return(status: 202)

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Export response header did not include "Content-Location"')
    end

    it 'fails when content-location header has no value' do
      stub_request(:get, bulk_export_url)
        .to_return(status: 202, headers: { 'content-type': nil })

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Export response header did not include "Content-Location"')
    end

    it 'fails when response to delete request is not 202' do
      stub_request(:get, bulk_export_url)
        .to_return(status: 202, headers: { 'content-location': polling_url })
      stub_request(:delete, polling_url)
        .with(headers: { authorization: "Bearer #{bearer_token}" })
        .to_return(status: 404)

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 202, but received 404')
    end

    it 'passes when delete request includes bearer token and response is 202' do
      stub_request(:get, bulk_export_url)
        .to_return(status: 202, headers: { 'content-location': polling_url })
      stub_request(:delete, polling_url)
        .with(headers: { authorization: "Bearer #{bearer_token}" })
        .to_return(status: 202)

      result = run(test_class, base_input)

      expect(result.result).to eq('pass')
    end
  end
end
