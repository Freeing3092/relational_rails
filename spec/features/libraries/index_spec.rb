require "rails_helper"

RSpec.describe Library do
  
# For each parent table
# As a visitor
# When I visit '/libraries'
# Then I see the name of each parent record in the system
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @dpl = Library.create!(name: 'Denver Public Library', public_library: true, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  describe 'As a visitor' do
    describe "When I visit '/libraries'" do
      it "I see the name of each parent record in the system" do
        visit '/libraries'
        expect(page).to have_content('Alexandria')
      end
      
      it "The libraries are sorted with the most recently created on top" do
        visit '/libraries'
        expect(page).to have_content('Alexandria')
        expect(page).to have_content('Denver Public Library')
        save_and_open_page
        expect('Denver Public Library').to appear_before('Alexandria')
      end
      
      it "I see a link at the top of the page that takes me to the Child Index" do
        visit "/libraries"
        expect(page).to have_link("Book Index")
        
        click_link("Book Index")
        expect(current_path).to eq("/books")
      end
      
      it "I see a link at the top of the page that takes me to the Parent Index" do
        visit "/libraries"
        expect(page).to have_link("Library Index")
        
        click_link("Library Index")
        expect(current_path).to eq("/libraries")
      end
    end
  end
end