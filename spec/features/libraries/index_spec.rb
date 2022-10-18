require "rails_helper"

RSpec.describe 'Library index' do
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
      
      it "The libraries are sorted with the most recently created on top
      and next to each of the records I see when it was created" do
        visit '/libraries'
        expect(page).to have_content('Alexandria')
        expect(page).to have_content('Denver Public Library')
        expect('Denver Public Library').to appear_before('Alexandria')
        expect(page).to have_content(@alexandria.created_at)
        expect(page).to have_content(@dpl.created_at)
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
      
      it "I see a link to create a new Parent record, 'New Library'. When I
      click that link I am taken to 'libraries/new'" do
        visit "/libraries"
        expect(page).to have_link("New Library")
        
        click_link("New Library")
        expect(current_path).to eq("/libraries/new")
      end
      
      it "Next to every library I see a link to edit that library's info. When
      I click the link I am taken to a page where I can update that info." do
        visit "/libraries"
        expect(page).to have_link("Update #{@alexandria.name}")
        
        click_link("Update #{@alexandria.name}")
        expect(current_path).to eq("/libraries/#{@alexandria.id}/edit")
      end
    end
  end
end