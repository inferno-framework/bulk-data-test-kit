# frozen_string_literal: true

require_relative '../../../lib/bulk_data_test_kit/v2.0.0_client/tags'
require_relative '../../../lib/bulk_data_test_kit/v2.0.0_client/urls'

RSpec.describe BulkDataTestKit::BulkDataV200Client do
  let(:suite_id) { 'bulk_data_v200_client' }
  let(:suite) { Inferno::Repositories::TestSuites.new.find( suite_id ) }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:results_repo) { Inferno::Repositories::Results.new }
  let(:requests_repo) { Inferno::Repositories::Requests.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite_id ) }

  let(:kickoff_test) { Inferno::Repositories::Tests.new.find('bulk_data_client_kick_off') }
  let(:status_test) { Inferno::Repositories::Tests.new.find('bulk_data_client_status') }
  let(:output_test) { Inferno::Repositories::Tests.new.find('bulk_data_client_output') }
  let(:delete_test) { Inferno::Repositories::Tests.new.find('bulk_data_client_delete') }

  let(:patient_kickoff_tag) { BulkDataTestKit::BulkDataV200Client::PATIENT_KICKOFF_TAG }
  let(:group_kickoff_tag) { BulkDataTestKit::BulkDataV200Client::GROUP_KICKOFF_TAG }
  let(:system_kickoff_tag) { BulkDataTestKit::BulkDataV200Client::SYSTEM_KICKOFF_TAG }
  let(:status_tag) { BulkDataTestKit::BulkDataV200Client::STATUS_TAG }
  let(:output_tag) { BulkDataTestKit::BulkDataV200Client::OUTPUT_TAG }
  let(:delete_tag) { BulkDataTestKit::BulkDataV200Client::DELETE_TAG }

  let(:patient_fail) { 'Did not receive a Patient type kick-off request.' }
  let(:group_fail) { 'Did not receive a Group type kick-off request.' }
  let(:system_fail) { 'Did not receive a System type kick-off request.' }
  let(:status_fail) { 'Did not receive a status request.' }
  let(:output_fail) { 'Did not receive a download request.' }
  let(:delete_fail) { 'Did not receive a delete request.' }

#  def run(runnable, inputs = {})
#    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
#    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
#    inputs.each do |name, value|
#      session_data_repo.save(
#        test_session_id: test_session.id,
#        name:,
#        value:,
#        type: runnable.config.input_type(name)
#      )
#    end
#    Inferno::TestRunner.new(test_session:, test_run:).run(runnable)
#  end

  def mock_request(result, tags, verb = 'get')
    requests_repo.create({
                           verb:,
                           url: 'https://www.example.com/',
                           direction: 'incoming',
                           result_id: result.id,
                           test_session_id: test_session.id,
                           tags:
                         })
  end

  describe 'Bulk Data Client' do
    describe 'kick-off test' do
      %w[Patient Group System].each do |type|
        describe "for #{type} type" do
          it 'passes after kick-off request received' do
            allow(kickoff_test).to receive_messages(suite:)
            result = run(kickoff_test, export_type: type)

            expect(result.result).to eq('fail')
            expect(result.result_message).to eq(send("#{type.downcase}_fail"))

            mock_request(result, [send("#{type.downcase}_kickoff_tag")])

            result = run(kickoff_test, export_type: type)

            expect(result.result).to eq('pass')
          end
        end
      end
    end

    describe 'status test' do
      it 'passes after status request received' do
        allow(status_test).to receive_messages(suite:)
        result = run(status_test)

        expect(result.result).to eq('fail')
        expect(result.result_message).to eq(status_fail)

        mock_request(result, [status_tag])

        result = run(status_test)

        expect(result.result).to eq('pass')
      end
    end

    describe 'output test' do
      it 'passes after export downloaded' do
        allow(output_test).to receive_messages(suite:)
        result = run(output_test)

        expect(result.result).to eq('fail')
        expect(result.result_message).to eq(output_fail)

        mock_request(result, [output_tag])

        result = run(output_test)

        expect(result.result).to eq('pass')
      end
    end

    describe 'delete test' do
      it 'passes after delete request received' do
        allow(delete_test).to receive_messages(suite:)
        result = run(delete_test)

        expect(result.result).to eq('fail')
        expect(result.result_message).to eq(delete_fail)

        mock_request(result, [delete_tag], 'delete')

        result = run(delete_test)

        expect(result.result).to eq('pass')
      end
    end
  end
end
