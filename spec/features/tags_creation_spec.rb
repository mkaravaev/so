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
    fill_in "Title", with: "example title"
    fill_in "Body", with: "example body"    
    fill_in "Tags", with: "Ruby on Rails"
    click_on "Ask"
    
    expect(page).to have_content "Ruby on Rails"
  end
end