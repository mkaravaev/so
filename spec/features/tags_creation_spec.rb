require_relative "feature_helper"

feature 'Creating tags', %q{
  In order to have sort question by category
  and search in them I as sign in user 
  want be able create tags
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario "Existing signed in user creating new tag" do
    sign_in(user)
    visit tags_path
    fill_in "Name", with: "Ruby on Rails"
    click_on "Create Tag"
    
    expect(page).to have_content "Ruby on Rails"
  end

  scenario "Non signed in user trying to creat tag" do
    visit tags_path
    expect(page).to_not have_content "Create Tag"
  end

  given!(:tag) { create(:tag) }

  scenario "Signed in user trying to create existing tag" do
    sign_in(user)
    visit tags_path
    fill_in "Name", with: tag.name
    click_on "Create Tag"
    
    expect(page).to have_content "Tag already exist!"
  end

end