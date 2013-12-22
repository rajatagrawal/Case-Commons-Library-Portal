class BooksController< ApplicationController
  load_and_authorize_resource

  def update
    @book.update_attributes params[:book]
    flash[:success] = "Successfully updated the book"
    redirect_to user_profile_path(current_user)
  end

  def create
    if @book.save
      flash[:success] = 'Added a new book successfully'
      redirect_to user_profile_path(current_user)
    elsif
      render 'new'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = 'Successfully deleted the book'
    redirect_to user_profile_path(current_user)
  end

  def checkout

    UserBook.create(
      user_id: current_user.id,
      book_id: @book.id,
      issued_on: Time.now
    )
    flash[:success] = 'Successfully checked out the book'
    redirect_to user_profile_path(current_user)
  end

  def checkin
    user_books = @book.user_books
    issued_user_book = user_books.select { | user_book| user_book.user_id == current_user.id }.first
    issued_user_book.returned_on = Time.now
    issued_user_book.save
    flash[:success] = 'Successfully checked in the book'
    redirect_to user_profile_path(current_user)
  end

  def error

  end
end
