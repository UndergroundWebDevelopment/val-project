require 'rails_helper'
require 'factories/operation'

RSpec.describe ActionLog::Update do
  let(:operation) { OperationFactory.default }
  let(:action) do
    Action::Create[action: {
      operation: operation,
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
      type: "create_github_issue",
    }].model
  end
  let(:action_log) do
    ActionLog.create({
      action: action,
      payload: {"foo" => "bar"},
    })
  end

  it "doesn't support updates" do
    ActionLog::Update[
      id: action_log.id,
      action_log: {
        action: "foobar",
        payload: {"bash" => "buzz"},
      }
    ].model

    action_log.reload

    expect(action_log.action).to eq action
    expect(action_log.payload).to eq({"foo" => "bar"})
  end
end
