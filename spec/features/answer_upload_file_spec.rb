require_relative "feature_helper"

feature 'Add files to answer', %q{
  In order to illustrate my answer I want have
  abillity to attach files
} do
  
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario "Authenticated user add file to his answer", js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'My answer123'
    attach_file 'file', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Put answer'
    
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end