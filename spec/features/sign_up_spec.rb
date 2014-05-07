require 'spec_helper'

feature 'Signing up', %q{
  In order to ask questions and give answers to others
  I as a visitor want be able to create new user account
} do

  let(:user){user = create(:user)}

  scenario "Visitor of a site try to sign up" do
    visit new_user_registration_path
    fill_in "Email", with: "test2@example.ru"
    fill_in "Password", with: "123456789", match: :first
    fill_in "Password confirmation", with: "123456789"
    fill_in "Name", with: "user"
    click_on "Sign up"
    
    
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario "Visitor try to sign up with existing e-mail" do

    visit new_user_registration_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password, match: :first
    fill_in "Password confirmation", with: user.password_confirmation
    click_on "Sign up"

    save_and_open_page
    expect(page).to have_content 'has already been taken'
  end
end