class LibrariesController < ApplicationController
  def index
    @libraries = Library.all.order(created_at: :desc)
  end
  
  def show
    @library = Library.find(params[:id])
    @library_books = @library.books.where("library_id = ?", params[:id])
  end
  
  def library_books
    @library = Library.find(params[:id])
    @library_books = @library.books.where("library_id = ?", params[:id])
  end
  
  def new
    # redirect_to "/libraries"
  end
  
  def create
    library = Library.new({
      name: params[:name],
      public_library: params[:public_library],
      employees: params[:employees],
      })
      library.save
      redirect_to "/libraries"
    
  end
end