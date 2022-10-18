class LibrariesController < ApplicationController
  def index
    @libraries = Library.order_by_created
  end
  
  def show
    @library = Library.find(params[:id])
  end
  
  def library_books
    @library = Library.find(params[:id])
    if !params[:minimum_page_count].nil?
      @library_books = @library.books.filter_by_page_count(params[:minimum_page_count])
    elsif params[:alpha]
      @library_books = @library.order_by_alpha
    else
      @library_books = @library.books.where("library_id = ?", params[:id])
    end
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
  
  def destroy
    library = Library.find(params[:id])
    library_books = library.books.where("library_id = ?", params[:id])
    library_books.each {|book| book.destroy}
    library.destroy
    redirect_to '/libraries'
  end
end