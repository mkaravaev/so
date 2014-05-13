require_relative "feature_helper"

feature 'Signing out' do

given(:user){ create(:user) }

  scenario "user click on sign out button" do
    sign_in(user)
    click_on "Log out"
    
    expect(page).to have_content "Signed out successfully"
  end
end