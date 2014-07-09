require_relative 'feature_helper'
# Capybara.default_driver = :webkit

feature "User can create question" do
  given!(:user){ create(:user) }
  

  scenario "Login user can create new Question" do
    sign_in(user)
    click_on "Ask question"
    fill_in "Title", with: "this is title"
    # page.execute_script('tinyMCE.activeEditor.setContent("Question 12345")')
    # page.driver.execute_script('$(".tinymce").value += "Question 12345"')
    fill_in "question_body", with: "Question 12345"
    click_on "Ask"
    save_and_open_page
    expect(page).to have_content "Question was successfully created."
    expect(page).to have_content "Question 12345"
  end
end