require 'spec_helper'

feature 'Signin in', %q{
  In order to ask 
  question I as a 
  user want be able to sign in
} do
  scenario "Existing user try to sign in" do
    User.create!(email: "test@example.ru", password: '123456789',
      password_confirmation: '123456789', name: 'Misa')

    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Non-existing user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'test1@example.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'
    save_and_open_page
    expect(page).to have_content "Forgot your password?"
  end
end