require "rails_helper"

RSpec.describe Library, type: :model do
  before :each do
    @alexandria = Library.create!(name: 'Alexendria', public_library: false, employees: 1)
    @dpl = Library.create!(name: 'Denver Public Library', public_library: true, employees: 1)
    @potter = @alexandria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter2 = @alexandria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  it { should have_many(:books) }
  
  it "#book_count counts the number of books for a library" do
    expect(@alexandria.book_count).to eq(2)
  end
  
  it "#order_by_created sorts the libraries by the order they were created with
  the most recently created on top" do
    expect(Library.order_by_created).to eq([@dpl, @alexandria])
  end
  
  it "#order_by_alpha sorts the library's books by alphabetical order" do
    expect(@alexandria.order_by_alpha).to eq([@potter2, @potter])
  end
  
  it "#filter_by_page_count returns books with a page count greater than the 
  number provided" do
    expect(@alexandria.books.filter_by_page_count(300)).to eq([@potter2])
    expect(@alexandria.books.filter_by_page_count(100)).to eq([@potter, @potter2])
    expect(@alexandria.books.filter_by_page_count(500)).to eq([])
  end
end