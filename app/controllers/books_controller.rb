class BooksController< ApplicationController

  def index
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])
  end

  def update
    Book.update(params[:id],params[:book])
    flash.now[:notice] = "The books has been successfully updated!"
    redirect_to action: :show
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
    redirect_to action: :index
  end

end
