require 'rails_helper'

RSpec.describe Operation::Create do
  it "persists valid" do
    operation = Operation::Create[operation: {
      name: "Github <-> Trello Sync",
      description: "Workflows to sync github issues and both ways with Trello Cards.",
    }].model

    expect(operation.persisted?).to be true
    expect(operation.name).to eq "Github <-> Trello Sync"
    expect(operation.description).to eq "Workflows to sync github issues and both ways with Trello Cards."
  end

  it "invalid" do
    res, op = Operation::Create.run(operation: {name: ""})

    expect(res).to eq false
    expect(op.model).to_not be_persisted
    expect(op.contract.errors.details[:name]).to eq([{error: "can't be blank"}])
  end
end

RSpec.describe Operation::Update do
  let(:operation) do
    Operation::Create[operation: {
      name: "Github <-> Trello Sync",
      description: "Workflows to sync github issues and both ways with Trello Cards.",
    }].model
  end

  it "persists valid" do
    Operation::Update[
      id: operation.id,
      operation: {
        name: "Google Enterprise Test",
        description: "Foobar bash description",
      }
    ].model

    operation.reload

    expect(operation.name).to eq "Google Enterprise Test"
    expect(operation.description).to eq "Foobar bash description"
  end
end

RSpec.describe Operation::Destroy do
  let(:operation) do
    Operation::Create[operation: {
      name: "Github <-> Trello Sync",
      description: "Workflows to sync github issues and both ways with Trello Cards.",
    }].model
  end

  it "destroys valid" do
    Operation::Destroy[
      id: operation.id,
    ]

    expect{operation.reload}.to raise_error ActiveRecord::RecordNotFound
  end
end
