require 'rails_helper'

RSpec.describe Book do
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  describe 'As a visitor' do
    it "When I fill in the form with the child's attributes: and I click the
    button 'Create Child' then a `POST` request is sent to
    '/parents/:parent_id/child_table_name', a new child object/row is created
    for that parent, and I am redirected to the Parent Childs Index page where
    I can see the new child listed" do
      visit "libraries/#{@alexandria.id}/books/new"
      
      fill_in "name", with: "Harry Potter and the Prisoner of Azkaban"
      fill_in "checked_out", with: "true"
      fill_in "pages", with: "430"
      
      expect(page).to have_button("Create Book")
      click_button "Create Book"
      
      expect(current_path).to eq("/libraries/#{@alexandria.id}/books")
      expect(page).to have_content('Harry Potter and the Prisoner of Azkaban')
    end
  end
end