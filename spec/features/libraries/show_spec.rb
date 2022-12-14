require "rails_helper"

RSpec.describe 'Library show' do
  
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  describe 'As a visitor' do
    describe "When I visit '/libraries/:id'" do
      it "I see the name of each parent record in the system" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_content('Alexandria')
        expect(page).to have_content('Public Library: false')
        expect(page).to have_content('Employees: 1')
      end
      
      it "Includes a a count of the Books belonging to the Library" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_content("Book Count: 2")
      end
      
      it "I see a link at the top of the page that takes me to the Child Index" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_link("Book Index")
        
        click_link("Book Index")
        expect(current_path).to eq("/books")
      end
      
      it "I see a link at the top of the page that takes me to the Parent Index" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_link("Library Index")
        
        click_link("Library Index")
        expect(current_path).to eq("/libraries")
      end
      
      it "I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_link("Library Book Index")
        
        click_link("Library Book Index")
        expect(current_path).to eq("/libraries/#{@alexandria.id}/books")
      end
      
      it "I see a link to update the parent 'Update Library', when I click that
      link, I am taken to 'libraries/:id/edit'" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_link("Update Library")
        
        click_link("Update Library")
        expect(current_path).to eq("/libraries/#{@alexandria.id}/edit")
      end
      
      it "I see a link to delete the Library. When I click the link 
      'Delete Parent' the library is deleted and all the library's books 
      are deleted. I am then redirected to the libraries index page where I
      no longer see this parent" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_link("Delete #{@alexandria.name}")
        
        click_link("Delete #{@alexandria.name}")
        expect(current_path).to eq("/libraries")
        expect(page).to_not have_content(@alexandria.name)
      end
    end
  end
end