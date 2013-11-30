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
    if @book.user.blank?
      @book.user = current_user
      @book.save!
      redirect_to user_profile_path(current_user)
    else
      render text: "You can not check out this book because this book has already been issued by '#{@book.user.first_name + ' ' + @book.user.last_name}."

    end

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
