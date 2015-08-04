require 'rails_helper'
require 'factories/channel'
require 'factories/event_log'

RSpec.describe EventLog::Create do
  let(:channel) { ChannelFactory.default }

  it "persists valid" do
    event_log = EventLog::Create[event_log: {
      channel_id: channel.id,
      type: "github_issue_created",
      payload: {"foo" => "bar"},
    }].model

    expect(event_log.persisted?).to be true
    expect(event_log.type).to eq "github_issue_created"
    expect(event_log.payload).to eq({"foo" => "bar"})
  end

  it "queues event to be processed later" do
    expect(ProcessEventsJob).to receive(:perform_later)

    EventLog::Create[event_log: {
      channel_id: channel.id,
      type: "github_issue_created",
      payload: {"foo" => "bar"},
    }].model
  end

  it "invalid" do
    res, op = EventLog::Create.run(event_log: {type: ""})

    expect(res).to eq false
    expect(op.model).to_not be_persisted
    expect(op.contract.errors.details[:type]).to eq([{error: "can't be blank"}])
  end
end

RSpec.describe EventLog::Update do
  let(:channel) { ChannelFactory.default }

  let(:event_log) do 
    EventLogFactory.default(
      channel: channel,
      type: "github_issue_created",
      payload: {"foo" => "bar"},
    )
  end

  it "does not update" do
    EventLog::Update[
      id: event_log.id,
      event_log: {
        type: "trello_card_created",
        payload: {"bash" => "buzz"},
      }
    ].model

    event_log.reload

    expect(event_log.type).to eq "github_issue_created"
    expect(event_log.payload).to eq({"foo" => "bar"})
  end
end
