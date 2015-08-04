require 'rails_helper'

RSpec.describe Action::Create do
  let(:operation) { Operation::Create[operation: {name: "Test Operation"}].model }

  it "persists valid" do
    action = Action::Create[action: {
      operation: operation,
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
      type: "create_github_issue",
    }].model

    expect(action.persisted?).to be true
    expect(action.name).to eq "Github"
    expect(action.description).to eq "Workflows to sync github issues and milestones with other apps."
    expect(action.operation_id).to eq operation.id
  end

  it "invalid" do
    res, op = Action::Create.run(action: {name: ""})

    expect(res).to eq false
    expect(op.model).to_not be_persisted
    expect(op.contract.errors.details[:type]).to eq([{error: "can't be blank"}])
  end
end

RSpec.describe Action::Update do
  let(:operation) { Operation::Create[operation: {name: "Test Operation"}].model }
  let(:action) do
    Action::Create[action: {
      operation: operation,
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
      type: "create_github_issue",
    }].model
  end

  it "persists valid" do
    Action::Update[
      id: action.id,
      action: {
        name: "Trello",
        description: "Workflows to sync trello cards.",
      }
    ].model

    action.reload

    expect(action.name).to eq "Trello"
    expect(action.description).to eq "Workflows to sync trello cards."
  end
end

RSpec.describe Action::Destroy do
  let(:operation) { Operation::Create[operation: {name: "Test Operation"}].model }
  let(:action) do
    Action::Create[action: {
      operation: operation,
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
      type: "create_github_issue",
    }].model
  end

  it "destroys valid" do
    Action::Destroy[
      id: action.id,
    ]

    expect{action.reload}.to raise_error ActiveRecord::RecordNotFound
  end
end
