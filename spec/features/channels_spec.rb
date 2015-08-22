require 'rails_helper'
require 'factories/channel'
require 'factories/user'

feature "Creating a channel " do
  given(:password) { Faker::Internet.password }
  given!(:user) { UserFactory.default(password: password) }

  background do
    # Sign in:
    visit 'sessions/sign_in_form'
    within("#new_session") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
    end
    click_button "Sign in!"
  end

  scenario "with valid options" do
    # Create a new channel:
    visit 'channels/new'
    within("#new_channel") do
      fill_in 'Name', with: "Trello"
      fill_in 'Type', with: "github"
    end
    click_button "Create Channel"
    expect(page).to have_content "Trello"
  end
end

feature "Updating a channel" do
  given(:password) { Faker::Internet.password }
  given!(:user) { UserFactory.default(password: password) }

  background do
    # Sign in:
    visit 'sessions/sign_in_form'
    within("#new_session") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
    end
    click_button "Sign in!"
  end

  given(:channel) do
    ChannelFactory.default({}, user)
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
