require 'rails_helper'

feature "Sign Up " do
  scenario "with valid options" do
    visit 'sessions/sign_up_form'
    within("#new_user") do
      password = Faker::Internet.password
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: password
      fill_in 'Confirm password', with: password
    end
    click_button "Sign up!"
    expect(page.current_path).to eq '/sessions/sign_in_form'
  end
end
