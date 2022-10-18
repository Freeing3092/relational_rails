require 'rails_helper'

RSpec.describe 'New Library' do
  describe 'As a visitor' do
    it "When I fill out the form with a new parent's attributes and I click
    the button 'Create Parent' to submit the form, then a `POST` request is sent 
    to the '/parents' route, a new parent record is created, and I am redirected
    to the Parent Index page where I see the new Parent displayed." do
      visit '/libraries/new'
      fill_in "name", with: "New York Public Library"
      fill_in "public_library", with: "true"
      fill_in "employees", with: "17"
      
      expect(page).to have_button("Create Library")
      click_button "Create Library"
      
      expect(current_path).to eq("/libraries")
      expect(page).to have_content("New York Public Library")
    end
      
  end
end