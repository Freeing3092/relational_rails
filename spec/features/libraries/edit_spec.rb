require 'rails_helper'

RSpec.describe Library do
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  describe 'As a visitor' do
    it "When I fill out the form with updated information and I click the button
    to submit the form then a `PATCH` request is sent to '/parents/:id', the
    parent's info is updated, and I am redirected to the Parent's Show page
    where I see the parent's updated info" do
      visit "/libraries/#{@alexandria.id}/edit"
      fill_in "name", with: "Moria"
      fill_in "public_library", with: "false"
      fill_in "employees", with: "3"
      
      expect(page).to have_button("Submit")
      click_button("Submit")
      
      expect(current_path).to eq("/libraries/#{@alexandria.id}")
      expect(page).to have_content("Moria")
    end
  end
end