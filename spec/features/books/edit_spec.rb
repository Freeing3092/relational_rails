require 'rails_helper'

RSpec.describe Book do
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
    # binding.pry
  end
  
  describe 'As a visitor' do
    it "I see a form to edit the child's attributes When I click the button to
    submit the form 'Update Book' then a `PATCH` request is sent to
    '/child_table_name/:id', the child's data is updated, and I am redirected
    to the Child Show page where I see the Child's updated information" do
      visit "/books/#{@potter.id}/edit"
      fill_in "name", with: "Harry Potter and the Goblet of Fire"
      fill_in "checked_out", with: "true"
      fill_in "pages", with: "458"
      
      expect(page).to have_button("Submit")
      click_button("Submit")
      
      expect(current_path).to eq("/books/#{@potter.id}")
      expect(page).to have_content("Harry Potter and the Goblet of Fire")
      expect(page).to have_content('Checked Out? true')
      expect(page).to have_content('Number of Pages: 458')
      expect(page).to have_content("Library ID: #{@potter.library_id}")
    end
    
    
      
    
  end
end