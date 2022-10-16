require 'rails_helper'

RSpec.describe Book do
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  describe 'As a visitor' do
    describe "When I visit 'libraries/:id/books'" do
      it "I see the name of each Book record in the system including attributes" do
        visit "libraries/#{@alexandria.id}/books"
        
        expect(page).to have_content("Harry Potter and The Sorcer's Stone")
        expect(page).to have_content('Checked Out? true')
        expect(page).to have_content('Number of Pages: 224')
        expect(page).to have_content("Harry Potter and The Chamber of Secrets")
        expect(page).to have_content('Checked Out? false')
        expect(page).to have_content('Number of Pages: 357')
      end
      
      it "I see a link at the top of the page that takes me to the Child Index" do
        visit "libraries/#{@alexandria.id}/books"
        expect(page).to have_link("Book Index")
        
        click_link("Book Index")
        expect(current_path).to eq("/books")
      end
      
      it "I see a link at the top of the page that takes me to the Parent Index" do
        visit "libraries/#{@alexandria.id}/books"
        expect(page).to have_link("Library Index")
        
        click_link("Library Index")
        expect(current_path).to eq("/libraries")
      end
      
      it "I see a link to add a new adoptable child for that parent 'Create Book'
      when I click the link I am taken to '/libraries/:library_id/library_books/new'" do
        visit "libraries/#{@alexandria.id}/books"
        expect(page).to have_link('Create Book')
        click_link('Create Book')
        
        expect(current_path).to eq("/libraries/#{@alexandria.id}/books/new")
      end
    end
  end
end