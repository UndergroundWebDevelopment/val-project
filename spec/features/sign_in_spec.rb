require 'rails_helper'
require 'factories/user'

feature "Sign In " do
  given(:password) { Faker::Internet.password }
  given!(:user) { UserFactory.default(password: password) }

  scenario "with valid options" do
    visit 'sessions/sign_in_form'
    within("#new_session") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
    end
    click_button "Sign in!"
    expect(page.current_path).to eq '/'
  end
end
