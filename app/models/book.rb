class Book < ApplicationRecord
  belongs_to :library
  
  def self.filter_by_page_count(page_count)
    where("pages > #{page_count}")
  end
end