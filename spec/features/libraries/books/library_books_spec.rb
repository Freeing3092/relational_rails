require 'rails_helper'

RSpec.describe 'Library books index' do
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
      
      it "I see a link to sort books in alphabetical order. When I click
      the link, I am taken back to the '/libraries/:id/books' index page where
      I see all the library's books in alphabetical order" do
        visit "libraries/#{@alexandria.id}/books"
        
        expect(page).to have_link('Sort Books Alphabetically')
        click_link('Sort Books Alphabetically')
        
        expect(current_path).to eq("/libraries/#{@alexandria.id}/books")
        
        first_book = "Harry Potter and The Chamber of Secrets"
        second_book = "Harry Potter and The Sorcer's Stone"
        
        expect(page).to have_content(first_book)
        expect(page).to have_content(second_book)
        expect(first_book).to appear_before(second_book)
      end
      
      it "next to every book, I see a link to edit that book's info. When I
      click that link I will be taken to '/books/:id/edit'" do
        visit "libraries/#{@alexandria.id}/books"
        expect(page).to have_link("Update #{@potter.name}")
        
        click_link("Update #{@potter.name}")
        expect(current_path).to eq("/books/#{@potter.id}/edit")
      end
      
      xit "I see a form that allows me to input a number value When I input a
      number value and click the submit button that reads 'Only return records
      with more than `number` of `pages`' Then I am brought back to the current
      index page with only the records that meet that threshold shown." do
        visit "libraries/#{@alexandria.id}/books"
        expect(page).to have_content(@potter2.name)
        expect(page).to have_content(@potter.name)
        
        fill_in "minimum_page_count", with: "300"
        click_button('Only return records with more than this number of pages')
        
        expect(current_path).to eq("/libraries/#{@alexandria.id}/books")
        expect(page).to have_content(@potter2.name)
        expect(page).to_not have_content(@potter.name)
      end
      
      
      it "Next to every child, I see a link to delete that child. When I click
      the link I should be taken to the `child_table_name` index page where I
      no longer see that child" do
        visit "libraries/#{@alexandria.id}/books"
        expect(page).to have_link("Delete #{@potter.name}")
        
        click_link("Delete #{@potter.name}")
        
        expect(current_path).to eq("/books")
        expect(page).to_not have_content(@potter.name)
      end
    end
  end
end