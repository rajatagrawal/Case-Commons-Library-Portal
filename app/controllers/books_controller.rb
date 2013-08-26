class BooksController< ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.create(params[:book])
  end

  def new
    @book = Book.new
  end

  def prepare_delete_page
    @books = Book.all
    render 'pre_delete'
  end

  def destroy
    @book = Book.find(params[:id]).destroy
    render 'post_delete'
  end

end
