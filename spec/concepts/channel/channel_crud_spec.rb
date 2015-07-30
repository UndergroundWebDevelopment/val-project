require 'rails_helper'

RSpec.describe Channel::Create do
  it "persists valid" do
    channel = Channel::Create[channel: {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
    }].model

    expect(channel.persisted?).to be true
    expect(channel.name).to eq "Github"
    expect(channel.description).to eq "Workflows to sync github issues and milestones with other apps."
  end

  it "invalid" do
    res, op = Channel::Create.run(channel: {name: ""})

    expect(res).to eq false
    expect(op.model).to_not be_persisted
    expect(op.errors.details[:name]).to eq([{error: "can't be blank"}])
  end
end

RSpec.describe Channel::Update do
  let(:channel) do
    Channel::Create[channel: {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
    }].model
  end

  it "persists valid" do
    Channel::Update[
      id: channel.id,
      channel: {
        name: "Trello",
        description: "Workflows to sync trello cards.",
      }
    ].model

    channel.reload

    expect(channel.name).to eq "Trello"
    expect(channel.description).to eq "Workflows to sync trello cards."
  end
end

RSpec.describe Channel::Destroy do
  let(:channel) do
    Channel::Create[channel: {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
    }].model
  end

  it "destroys valid" do
    Channel::Destroy[
      id: channel.id,
    ]

    expect{channel.reload}.to raise_error ActiveRecord::RecordNotFound
  end
end
