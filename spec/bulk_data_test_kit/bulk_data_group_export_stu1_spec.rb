# frozen_string_literal: true

require_relative '../../lib/bulk_data_test_kit/v1.0.1/group/bulk_data_group_export_group'

RSpec.describe BulkDataTestKit::BulkDataV101::BulkDataGroupExportGroup do
  let(:suite_id) { 'bulk_data_v101' }
  let(:bulk_server_url) { 'https://example.com/fhir' }
  let(:group_id) { '1219' }
  let(:bearer_token) { 'some_bearer_token_alphanumeric' }
  let(:polling_url) { 'https://redirect.com' }
  let(:bulk_timeout) { 180 }
  let(:base_input) do
    {
      group_id:,
      smart_auth_info: Inferno::DSL::AuthInfo.new({ auth_type: :backend_services, access_token: bearer_token })
    }
  end
  let(:capability_statement) { FHIR.from_contents(File.read('spec/fixtures/CapabilityStatement.json')) }
  let(:status_response) do
    '{"transactionTime":"2021-11-30T13:40:29.828Z","request":"https://inferno.healthit.gov/bulk-data-server/' \
      'eyJlcnIiOiIiLCJwYWdlIjoxMDAwMCwiZHVyIjoxMCwidGx0Ijo2MCwibSI6MSwic3R1Ijo0LCJkZWwiOjB9/fhir/Group/' \
      '1f76e2b7-a222-4765-9097-a71b86e90d07/$export","requiresAccessToken":true,"output":[],"deleted":[],"error":[]}'
  end
  let(:status_output) do
    '{"output":[{"type":"AllergyIntolerance","count":14,"url":"https://bulk-data.smarthealthit.org/' \
      'eyJpZCI6ImQzOWY5MTgxN2JjYTkwZGI2YTgyYTZiZDhkODUwNzQ1Iiwib2Zmc2V0IjowLCJsaW1pdCI6MTQsInNlY3VyZSI6dHJ1ZX0/fhir/' \
      'bulkfiles/1.AllergyIntolerance.ndjson"},{"type":"CarePlan","count":69,"url":"https://bulk-data.smarthealthit.' \
      'org/eyJpZCI6ImQzOWY5MTgxN2JjYTkwZGI2YTgyYTZiZDhkODUwNzQ1Iiwib2Zmc2V0IjowLCJsaW1pdCI6NjksInNlY3VyZSI6dHJ1ZX0/' \
      'fhir/bulkfiles/1.CarePlan.ndjson"}]}'
  end

  describe '[Bulk Data Server declares support for Group export operation in CapabilityStatement] test' do
    let(:runnable) { described_class.tests[1] }

    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV101::BulkDataExportOperationSupportTest) do
        fhir_client :bulk_server do
          url 'https://example.com/fhir'
        end

        http_client :bulk_server do
          url 'https://example.com/fhir'
        end

        config(
          options: { resource_type: 'Group' }
        )
      end
    end

    it 'fails when CapabilityStatement can not be retrieved' do
      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 400)

      result = run(test_class)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, 201, but received 400')
    end

    it 'fails when CapabilityStatement returned is not JSON' do
      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 200, body: 'not_json')

      result = run(test_class)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Invalid JSON. ')
    end

    it 'fails when server does not declare support for the Group resource in CapabilityStatement' do
      capability_statement.rest.first.resource.delete_at(1)

      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 200, body: capability_statement.to_json)

      result = run(test_class)

      expect(result.result).to eq('fail')
      expect(result.result_message)
        .to eq('Server CapabilityStatement did not declare support for any operations on the Group resource')
    end

    it 'fails when server does not declare support for any Group operations in CapabilityStatement' do
      capability_statement.rest.first.resource[1].operation = []

      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 200, body: capability_statement.to_json)

      result = run(test_class)

      expect(result.result).to eq('fail')
      expect(result.result_message)
        .to eq('Server CapabilityStatement did not declare support for any operations on the Group resource')
    end

    it 'passes when server declares support export in CapabilityStatement' do
      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 200, body: capability_statement.to_json)

      result = run(test_class)

      expect(result.result).to eq('pass')
    end

    it 'passes when server declares support for group export in CapabilityStatement with wrong name' do
      capability_statement.rest.first.resource[1].operation.first.name = 'bad-name'
      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 200, body: capability_statement.to_json)

      result = run(test_class)

      expect(result.result).to eq('pass')
    end

    it 'passes when server declares support for group export in CapabilityStatement' do
      capability_statement.rest.first.resource[1].operation.first.name = 'export'
      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 200, body: capability_statement.to_json)

      result = run(test_class)

      expect(result.result).to eq('pass')
    end

    it 'passes when server declars support of a potentially derived export operation' do
      capability_statement.rest.first.resource[1].operation.first.definition = 'https://example.org/fhir/uv/bulkdata/OperationDefinition/group-export|1.0.0'

      stub_request(:get, "#{bulk_server_url}/metadata")
        .to_return(status: 200, body: capability_statement.to_json)

      result = run(test_class)

      expect(result.result).to eq('pass')
    end
  end

  describe '[Bulk Data Server rejects $export request without authorization] test' do
    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV101::BulkDataGroupExportNoAuthRejectTest) do
        fhir_client :bulk_server do
          url 'https://example.com/fhir'
        end

        http_client :bulk_server do
          url 'https://example.com/fhir'
        end
      end
    end

    let(:bad_token_input) do
      base_input.merge({ smart_auth_info: Inferno::DSL::AuthInfo.new({ auth_type: :backend_services }) })
    end

    it 'skips if bearer_token not provided' do
      result = run(test_class, bad_token_input)

      expect(result.result).to eq('skip')
      expect(result.result_message).to eq('Bearer token is not set and thus not required to connect to server.')
    end

    it 'fails if client can $export without authorization' do
      stub_request(:get, "#{bulk_server_url}/Group/#{group_id}/$export")
        .to_return(status: 200)

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 400, 401, but received 200')
    end

    it 'passes if client can not $export without authorization' do
      stub_request(:get, "#{bulk_server_url}/Group/#{group_id}/$export")
        .to_return(status: 401)

      result = run(test_class, base_input)
      expect(result.result).to eq('pass')
    end
  end

  describe '[Bulk Data Server returns "202 Accepted" and "Content-location" for $export] test' do
    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV101::BulkDataGroupKickOffTest) do
        fhir_client :bulk_server do
          url 'https://example.com/fhir'
        end

        http_client :bulk_server do
          url 'https://example.com/fhir'
        end
      end
    end

    it 'fails when server does not return "202 Accepted"' do
      stub_request(:get, "#{bulk_server_url}/Group/#{group_id}/$export")
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 401)

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 202, but received 401')
    end

    it 'fails when server does not return "Content-Location" header' do
      stub_request(:get, "#{bulk_server_url}/Group/#{group_id}/$export")
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 202)

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Export response headers did not include "Content-Location"')
    end

    it 'fails when no value for "Content-Location" header' do
      stub_request(:get, "#{bulk_server_url}/Group/#{group_id}/$export")
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 202, headers: { 'content-location' => nil })

      result = run(test_class, base_input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Export response headers did not include "Content-Location"')
    end

    it 'passes when server returns both "202 Accepted" and "Content-location"' do
      stub_request(:get, "#{bulk_server_url}/Group/#{group_id}/$export")
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 202, headers: { 'content-location' => polling_url })

      result = run(test_class, base_input)

      expect(result.result).to eq('pass')
    end
  end

  describe '[Bulk Data Server returns "202 Accepted" or "200 OK" for status check] test' do
    let(:input) { base_input.merge(polling_url:).merge(bulk_timeout:).except(:group_id) }
    let(:headers) { { 'content-type' => 'application/json' } }
    let(:incomplete_status_response) do
      status_response_json = JSON.parse(status_response)
      status_response_json.delete('transactionTime')
      status_response_json.to_json
    end

    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV101::BulkDataStatusCheckTest) do
        fhir_client :bulk_server do
          url 'https://example.com/fhir'
        end

        http_client :bulk_server do
          url 'https://example.com/fhir'
        end

        config(
          options: { resource_type: 'Group' }
        )
      end
    end

    it 'skips when polling_url is not provided' do
      result = run(test_class, input.except(:polling_url))

      expect(result.result).to eq('skip')
      expect(result.result_message).to eq("Input 'polling_url' is nil, skipping test.")
    end

    it 'skips when server only returns "202 Accepted", and not "200 OK" in the allowed timeframe' do
      stub_request(:get, polling_url.to_s)
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 202)

      regex = /^#{'Server already used \\d+(\\.\\d+)? seconds processing this request, ' \
        'and next poll is \\d+ seconds after. ' \
        'The total wait time for next poll is more than \\d+ seconds time out setting.'}$/

      allow_any_instance_of(test_class).to receive(:sleep)
      result = run(test_class, input)

      expect(result.result).to eq('skip')
      expect(result.result_message).to match(regex)
    end

    it 'fails when server does not return "202 Accepted" nor "200 OK' do
      stub_request(:get, polling_url.to_s)
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 401)

      result = run(test_class, input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 401')
    end

    it 'fails when server returns "200 OK" and impromper headers' do
      stub_request(:get, polling_url.to_s)
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 200, body: 'invalid_status_response', headers: { 'bad' => 'headers' })

      result = run(test_class, input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Content-Type not application/json')
    end

    it 'fails when server returns "200 OK" and response body does not contain required attributes' do
      stub_request(:get, polling_url.to_s)
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 200, body: incomplete_status_response, headers:)

      result = run(test_class, input)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Complete Status response did not contain "transactionTime" as required')
    end

    it 'passes when server returns "202 Accepted" and response body contains required attributes' do
      stub_request(:get, polling_url.to_s)
        .with(headers: { 'Authorization' => "Bearer #{bearer_token}" })
        .to_return(status: 200, body: status_response, headers:)

      result = run(test_class, input)

      expect(result.result).to eq('pass')
    end

    it 'sends content type headers' do
      get_stub = stub_request(:get, polling_url.to_s)
                 .with(headers: {
                         'Authorization' => "Bearer #{bearer_token}",
                         'Accept' => 'application/json'
                       })

      run(test_class, input)

      assert_requested get_stub
    end
  end

  describe '[Bulk Data Server returns output with type and url for status complete] test' do
    let(:test_class) do
      Class.new(BulkDataTestKit::BulkDataV101::BulkDataOutputCheckTest) do
        fhir_client :bulk_server do
          url 'https://example.com/fhir'
        end

        http_client :bulk_server do
          url 'https://example.com/fhir'
        end

        config(
          options: { resource_type: 'Group' }
        )
      end
    end

    let(:bad_status_output) do
      status_output_json = JSON.parse(status_output)
      status_output_json['output'][1].delete('type')
      status_output_json.to_json
    end
    let(:group_id) { '1219' }

    it 'skips when response not found' do
      result = run(test_class)

      expect(result.result).to eq('skip')
      expect(result.result_message).to eq("Input 'status_response' is nil, skipping test.")
    end

    it 'fails when response does not contain output' do
      result = run(test_class, { status_response: '{"no_output":"!"}' })

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Bulk Data Server status response does not contain output')
    end

    it 'fails when output does not contain required attributes' do
      result = run(test_class, status_response: bad_status_output )

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Output file did not contain "type" as required')
    end

    it 'passes when response contains output with required attributes' do
      result = run(test_class, status_response: status_output )

      expect(result.result).to eq('pass')
    end
  end
end
