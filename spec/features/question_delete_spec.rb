require_relative 'feature_helper'

feature "User wants to delete his question" do 
    
  given(:user) { create :user }
  given(:question) { create :question, user: user }

  background do
    sign_in user
    visit question_path(question)
  end

  scenario "authenticated see delete button when visiting his question page" do
    expect(page).to have_content "Delete"
  end

  scenario "authenticated user wants to delete his question", js: true do
    click_on "Delete"
    page.driver.accept_js_confirms!
    expect(page).to have_content "Question was successfully destroyed"
    expect(page).to_not have_content question.title
  end

end