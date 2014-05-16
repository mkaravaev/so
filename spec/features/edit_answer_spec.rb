require_relative 'feature_helper'

feature "Answer editing", %q{
  In order to fix mistake I want to 
  edit my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'Unauthorized user try to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe "Authenticated user" do 
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to edit' do
      within '.answers' do
        expect(page).to have_link "Edit"
      end
    end

    scenario 'try to edit his answer', js: true do
      click_on "Edit"
      within ".edit_answer" do
        fill_in "Answer", with: 'edited answer'
        click_on "Save"
      end
      within '.answers' do
        expect(page).to_not have_content answer.body
        expect(page).to have_content "edited answer"
        expect(page).to_not have_selector "textarea"
      end
    end

    given(:user2) { create(:user, email: "this@email.com", password: "password",
                                    password_confirmation: "password") }
    scenario 'User sees edit link only if he is answer owner' do
      click_on "Log out"
      sign_in user2

      visit question_path(question)

      expect(page).to_not have_link "Edit"
    end
  end
end