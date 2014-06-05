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

  scenario "authenticated user wants to delete his question" do
    click_on "Delete"
    page.driver.browser.accept_js_confirms
    expect(Question.all).to_not have(id: question.id)
  end

end