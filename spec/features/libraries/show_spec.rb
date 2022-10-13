require "rails_helper"

RSpec.describe Library do
  
# For each parent table
# As a visitor
# When I visit '/libraries'
# Then I see the name of each parent record in the system
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  describe 'As a visitor' do
    describe "When I visit '/libraries/:id'" do
      it "I see the name of each parent record in the system" do
        visit "/libraries/#{@alexandria.id}"
        expect(page).to have_content('Alexandria')
        expect(page).to have_content('Public Library: false')
        expect(page).to have_content('Employees: 1')
      end
    end
  end
end