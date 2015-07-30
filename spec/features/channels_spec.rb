require 'rails_helper'

feature "Creating a channel " do
  scenario "with valid options" do
    visit 'channels/new'
    within("#new_channel") do
      fill_in 'Name', with: "Trello"
    end
    click_button "Create Channel"
    expect(page).to have_content "Trello"
  end
end

feature "Updating a channel" do
  given(:channel) do
    Channel::Create[channel: {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
    }].model
  end

  scenario "with valid options" do
    visit "channels/#{channel.id}/edit"

    within("#edit_channel_#{channel.id}") do
      fill_in 'Name', with: "Trello"
    end
    click_button "Update Channel"
    expect(page).to have_content "Trello"
  end
end
