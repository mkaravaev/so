require_relative "feature_helper"

feature "User want to add comment to question", %q{
  In order to add some specific information to question, I as User
  want to have ability to add comments to question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario "authenticated user add comment to question" do
    sign_in user
    visit question_path(question)
    click_on "Add comment"
    fill_in "Your comment", with: 'This is comment'
    click_on "Make comment"

    within ".comments" do
      expect(page).to have_content("This is comment")
    end
  end

end