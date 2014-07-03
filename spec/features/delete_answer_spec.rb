require_relative "feature_helper"

feature "User want to delete his answer" do

  given(:question) { create(:question) }
  given(:user) { create(:user) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }
  
  background do
    sign_in user 
  end

  scenario "Authenticated owner of answer see Delete link for his answer" do
    visit question_path(question)
    expect(page).to have_link "Delete"
  end

  given(:user2) {create(:user, email: "this@email.com", password: "password", password_confirmation: "password")}
  
  scenario "User can't see delete button on answers that doesn't belongs to him" do
    click_on "Log out"
    sign_in user2
    visit question_path(question)
    expect(page).to_not have_link "Delete"
  end

  scenario "Answer dissapear from page after user delete it", js: true do
    visit question_path(question)
    within ".answers" do
      click_on "Delete"
    end
    save_and_open_page
    page.driver.browser.accept_js_confirms
    expect(page).to_not have_content answer.body
    
  end
end