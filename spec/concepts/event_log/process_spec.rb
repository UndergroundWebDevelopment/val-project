require 'rails_helper'
require 'event_log/process'
require 'factories/channel'
require 'factories/event_log'
require 'factories/operation'
require 'factories/action'

RSpec.describe EventLog::Process do
  let(:event_type) { "github_issue_created" }
  let(:channel) { ChannelFactory.default }
  let(:event_log) { EventLogFactory.default(channel: channel, type: event_type) }

  context "with a matching operation, having at least one action" do
    let!(:operation) { OperationFactory.default(event_type: event_type) }
    let!(:action) { ActionFactory.default(operation: operation) }

    it "runs the actions on matching operations" do
      expect(ProcessActionJob).to receive(:perform_later)
      event_log # just loading the object triggers it to be processed.
    end
  end

  it "sets the event_log record processed" do
    processed_event_log = EventLog::Process[id: event_log.id].model

    expect(processed_event_log.persisted?).to be true
    expect(processed_event_log.last_started_processing_at).to be
    expect(processed_event_log.successfully_processed_at).to be
  end
end
