require "spec_helper"

feature "User answer", %q{
  In order to exchange my knowledge
  As an authenticated User
  I want to be able to create answers
  }  do
  given(:user) { create(:user) }
  given(:question) {create(:question) }

  scenario "Authenicated user create answer", js: true do
    sign_in(user)
    visit question_path(question)
    fill_in "Your answer", with: 'Some answer'
    click_on "Put answer"

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'Some answer'
    end
  end 
end