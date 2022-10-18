require "rails_helper"

RSpec.describe Book, type: :model do
  before :each do
    @alexendria = Library.create!(name: 'Alexendria', public_library: false, employees: 1)
    @potter = @alexendria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexendria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  it { should belong_to(:library) }
  
  it "#filter_by_page_count returns books with a page count greater than the 
  number provided" do
    expect(Book.filter_by_page_count(0)).to eq([@potter, @potter2])
    expect(Book.filter_by_page_count(300)).to eq([@potter2])
    expect(Book.filter_by_page_count(500)).to eq([])
  end
end