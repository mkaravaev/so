require_relative "feature_helper"

feature 'Signin in', %q{
  In order to ask 
  question I as a 
  user want be able to sign in
} do
  
  given(:user){ create(:user) }
  
  scenario "Existing user try to sign in" do
  
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Non-existing user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'test1@example.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    
    expect(page).to have_content "Forgot your password?"
  end
end