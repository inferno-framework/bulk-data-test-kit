require_relative '../../lib/bulk_data_test_kit/v1.0.1/bulk_data_smart_discovery_v101_contents_test'
require 'pry'

RSpec.describe BulkDataTestKit::BulkDataV101::BulkDataSmartDiscoveryV1ContentsTest do
  let(:runnable) { Inferno::Repositories::Tests.new.find('bulk_data_smart_discovery_v101_contents') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:results_repo) { Inferno::Repositories::Results.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: 'bulk_data_v101') }
  let(:correct_metadata) {
    {
      'token_endpoint' => 'https://example.org/auth/token',
      'token_endpont_auth_methods_supported' => ['private_key_jwt'],
      'token_endpoint_auth_signing_alg_values_supported' => [ 'RS384', 'ES384' ],
      'scopes_supported' => ['system/*.read']
    }
  }
  
  let(:recommended_capabilities) {
    [
      'token_endpont_auth_methods_supported',
      'token_endpoint_auth_signing_alg_values_supported',
      'scopes_supported'
    ]
  }
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

  it 'skips if well-known metadata is not present' do
    result = run(runnable, well_known_configuration: '')

    expect(result.result).to eq('skip')
  end

  it 'passes with all required and recommended fields' do
    result = run(runnable, well_known_configuration: JSON.generate(correct_metadata))

    expect(result.result).to eq('pass')
  end

  it 'passes with required field but missing recommended fields' do
    recommended_capabilities.each do |key|
      metadata = correct_metadata
      metadata.delete(key)
      result = run(runnable, well_known_configuration: JSON.generate(metadata))
      expect(result.result).to eq('pass')
    end
  end

  it 'fails when token_endpoint field is missing' do
    metadata = correct_metadata
    metadata.delete('token_endpoint')
    result = run(runnable, well_known_configuration: JSON.generate(metadata))
    expect(result.result).to eq('fail')
    expect(result.result_message).to match(/does not include `token_endpoint`/)
  end

  it 'fails with incorrect token_endpoint contents' do
    incorrect_token_endpoint_values = {
      '' => '`token_endpoint` is blank',
      'not_a_uri' => 'not a valid URI',
      ['https://example.org/auth/token'] => '`token_endpoint` must be type'
    }

    metadata = correct_metadata

    incorrect_token_endpoint_values.each do |key, value|
      metadata['token_endpoint'] = key
      result = run(runnable, well_known_configuration: JSON.generate(metadata))
      expect(result.result).to eq('fail')
      expect(result.result_message).to match(value)
    end
  end
end
