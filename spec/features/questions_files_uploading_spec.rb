require_relative "feature_helper"

feature "user can attach file to his answer or question" do

  given(:user){ create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario "authenticated user attach 1 file to his question" do    
    fill_in 'Title', with: 'This is example question'
    fill_in 'Body', with: 'This is example answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Ask'
    expect(page).to have_link "spec_helper.rb", href: "/uploads/attachment/file/1/spec_helper.rb"
  end

  # scenario "authenticated user attach two files to his question", js: :true do   
  #   fill_in 'Title', with: 'This is example question'
  #   fill_in 'Body', with: 'This is example answer'
  #   click_on '+ add more'
  #   attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
  #   attach_file 'File', "#{Rails.root}/README.rdoc"
  #   attach_file 'File', "#{Rails.root}/README.rdoc"
  #   click_on 'Ask'
  #   expect(page).to have_link "spec_helper.rb", href: "/uploads/attachment/file/1/spec_helper.rb"
  #   expect(page).to have_link "README.rdoc", href: "/uploads/attachment/file/2/README.rdoc"
  # end
end