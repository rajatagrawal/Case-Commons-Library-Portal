class BooksController< ApplicationController
  load_and_authorize_resource

  def update
    @book.update_attributes params[:book]
    flash[:success] = "Successfully updated the book"
    redirect_to user_profile_path(current_user)
  end

  def create
    @book.save!
    flash[:success] = 'Added a new book successfully'
    redirect_to user_profile_path(current_user)
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
    if @book.user == current_user
      @book.user = nil
      @book.save!
      redirect_to user_profile_path(current_user)
    else
      render text: 'You cannot check in this book'
    end
  end

  def error

  end
end
