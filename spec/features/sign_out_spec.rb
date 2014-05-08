require 'spec_helper'

feature 'Signing out' do

given(:user){ create(:user) }

  scenario "user click on sign out button" do
    sign_in(user)
    click_on "Log out"
    save_and_open_page
    expect(page).to have_content "Signed out successfully"
  end
end