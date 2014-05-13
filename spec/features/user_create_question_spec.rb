require_relative "feature_helper"
require 'rspec/expectations'

feature "User can create question" do
  given(:user){ create(:user) }

  scenario "Login user can create new Question" do
    sign_in(user)
    visit "/questions"
    click_on "Ask question"
    fill_in "Title", with: "this is title"
    fill_in "Body", with: "Who creates Ruby?"
    click_on "Ask"

    expect(page).to have_content "Question created!"
  end
end