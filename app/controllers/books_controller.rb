class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def new
    @library = Library.find(params[:id])
  end
  
  def create
    book = Book.new({
      name: params[:name],
      checked_out: params[:checked_out],
      pages: params[:pages],
      library_id: params[:library_id]
      })
    book.save
    redirect_to "/libraries/#{params[:library_id]}/books"
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update({
      name: params[:name],
      checked_out: params[:checked_out],
      pages: params[:pages],
      library_id: params[:library_id]
      })
      book.save
      redirect_to "/books/#{params[:id]}"
  end
end