require_relative "feature_helper"

feature "User can create question" do
  given(:user){ create(:user) }

  scenario "Login user can create new Question" do
    sign_in(user)
    visit "/questions"
    click_on "Ask question"
    fill_in "Title", with: "this is title"
    page.execute_script('$("#foo_description_raw").tinymce().setContent("Pants are pretty sweet.")')
    within ".tinymce" do
      fill_in "Body", with: "Who creates Ruby?"
    end
    click_on "Ask"

    expect(page).to have_content "Question created!"
  end
end