require 'rails_helper'

RSpec.describe Book do
  before :each do
    @alexandria = Library.create!(name: 'Alexandria', public_library: false, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  
  # As a visitor
  # When I visit '/child_table_name'
  # Then I see each Child in the system including the Child's attributes
  # (data from each column that is on the child table)
  
  describe 'As a visitor' do
    describe "When I visit '/books/:id'" do
      it "I see the name of each Book record in the system including attributes" do
        visit "/books/#{@potter.id}"
        
        expect(page).to have_content("Harry Potter and The Sorcer's Stone")
        expect(page).to have_content('Checked Out? true')
        expect(page).to have_content('Number of Pages: 224')
      end
    end
  end
end