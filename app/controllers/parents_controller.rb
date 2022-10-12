class ParentsController < ApplicationController
  def index
    @libraries = Library.all
  end
  
  def show
    @library = Library.find(params[:id])
  end
  
  def child_show
    @library = Library.find(params[:id])
    @library_books = Book.where("library_id = ?", params[:id])
  end
end