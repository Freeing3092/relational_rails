class Library < ApplicationRecord
  has_many :books
  
  def book_count
    books.count
  end
  
  def self.order_by_created
    order(created_at: :desc)
  end
end