class BooksController< ApplicationController
  load_and_authorize_resource

  def update
    @book.update_attributes params[:book]
    flash.now[:notice] = "The books has been successfully updated!"
    redirect_to action: :show
  end

  def create
    @book.save!
  end

  def destroy
    @book.destroy!
    redirect_to action: :index
  end

  def checkout
    @book.user = current_user
    @book.save!
    @books = Book.all
    render 'index'
  end
end
