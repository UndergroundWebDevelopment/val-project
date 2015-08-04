require 'rails_helper'

RSpec.describe EventLog::Create do
  let(:channel) do
    Channel::Create[channel: {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
    }].model
  end

  it "persists valid" do
    event_log = EventLog::Create[event_log: {
      channel: channel,
      type: "github_issue_created",
      payload: {"foo" => "bar"},
    }].model

    expect(event_log.persisted?).to be true
    expect(event_log.type).to eq "github_issue_created"
    expect(event_log.payload).to eq({"foo" => "bar"})
  end

  it "invalid" do
    res, op = EventLog::Create.run(event_log: {type: ""})

    expect(res).to eq false
    expect(op.model).to_not be_persisted
    expect(op.contract.errors.details[:type]).to eq([{error: "can't be blank"}])
  end
end

RSpec.describe EventLog::Update do
  let(:channel) do
    Channel::Create[channel: {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
    }].model
  end

  let(:event_log) do
    EventLog::Create[event_log: {
      channel: channel,
      type: "github_issue_created",
      payload: {"foo" => "bar"},
    }].model
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
