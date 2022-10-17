class LibrariesController < ApplicationController
  def index
    @libraries = Library.all.order(created_at: :desc)
  end
  
  def show
    @library = Library.find(params[:id])
  end
  
  def library_books
    @library = Library.find(params[:id])
    @library_books = @library.books.where("library_id = ?", params[:id])
  end
  
  def sort_library_books
    @library = Library.find(params[:id])
    @library_books = @library.books.where("library_id = ?", params[:id])
    @library_books = @library_books.order(:name)
    
    # The below method will render the page correctly, but the URL needs to be fixed
    render :library_books
  end
  
  def new
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
  
  def edit
    @library = Library.find(params[:id])
  end
  
  def update
    library = Library.find(params[:id])
    library.update({
      name: params[:name],
      public_library: params[:public_library],
      employees: params[:employees],
      })
      library.save
    redirect_to "/libraries/#{library.id}"
  end
end