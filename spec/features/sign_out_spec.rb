require 'spec_helper'

feature 'Signing out' do

let(:user){@user = create(:user)}

  scenario "user click on sign out button" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Sign in"
    click_on "Log out"
    save_and_open_page
    expect(page).to have_content "Signed out successfully"
  end
end