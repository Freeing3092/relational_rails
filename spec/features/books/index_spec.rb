require 'rails_helper'

RSpec.describe 'Books index' do
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcerer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  describe 'As a visitor' do
    describe "When I visit '/books'" do
      it "I see the name of each Book record in the system including attributes
      only if the boolean value is true" do
        visit "/books"
        
        expect(page).to have_content("Harry Potter and The Sorcerer's Stone")
        expect(page).to have_content('Checked Out? true')
        expect(page).to have_content('Number of Pages: 224')
        expect(page).to_not have_content("Harry Potter and The Chamber of Secrets")
        expect(page).to_not have_content('Checked Out? false')
        expect(page).to_not have_content('Number of Pages: 357')
      end
      
      it "I see a link at the top of the page that takes me to the Child Index" do
        visit "/books"
        expect(page).to have_link("Book Index")
        
        click_link("Book Index")
        expect(current_path).to eq("/books")
      end
      
      it "I see a link at the top of the page that takes me to the Parent Index" do
        visit "/books"
        expect(page).to have_link("Library Index")
        
        click_link("Library Index")
        expect(current_path).to eq("/libraries")
      end
      
      it "next to every book, I see a link to edit that book's info. When I
      click that link I will be taken to '/books/:id/edit'" do
        visit "/books"
        expect(page).to have_link("Update #{@potter.name}")
        
        click_link("Update #{@potter.name}")
        expect(current_path).to eq("/books/#{@potter.id}/edit")
      end
      
      it "Next to every child, I see a link to delete that child. When I click
      the link I should be taken to the `child_table_name` index page where I
      no longer see that child" do
        visit "/books"
        expect(page).to have_link("Delete #{@potter.name}")
        
        click_link("Delete #{@potter.name}")
        
        expect(current_path).to eq("/books")
        expect(page).to_not have_content(@potter.name)
      end
    end
  end
end