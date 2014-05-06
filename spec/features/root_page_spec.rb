require 'spec_helper'

feature 'Questions on root page', %q{
  In order to know what this site is about
  I as visitor(non-sign in) want be able to see questions
  on main 
} do

  scenario "Visitor type adress of the root page into his browser" do
    visit root_path
    expect(page).to have_selector('header')
    expect(page).to have_selector('footer')
    expect(page).to have_selector('topbar')

  end
end  