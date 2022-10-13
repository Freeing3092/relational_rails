require "rails_helper"

RSpec.describe Library, type: :model do
  before :each do
    @alexendria = Library.create!(name: 'Alexendria', public_library: false, employees: 1)
    @potter = @alexendria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
    @potter = @alexendria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)
  end
  it { should have_many(:books) }
  
end