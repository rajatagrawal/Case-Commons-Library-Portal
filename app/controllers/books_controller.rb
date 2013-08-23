class BooksController< ApplicationController

  def index
    @books = Book.all
  end

  def show

  end

  def create
    @book = Book.create(params[:book])
  end

  def new
    puts 'This is the new function of the books controller'
    @book = Book.new
    @hi = "This is hi variable"
  end

  def prepare_delete_page
    @books = Book.all
    render 'pre_delete'
  end

  def destroy
    binding.pry
    @book = Book.new(params[:book])
    render 'post_delete'
  end

end
