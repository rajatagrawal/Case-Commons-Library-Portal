class UsersController< ApplicationController
  load_and_authorize_resource

  def destroy
    @user.destroy
    flash[:success] = 'Successfully deleted the user.'
    redirect_to user_profile_path(current_user)
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = 'Successfully updated the user.'
      redirect_to user_profile_path(current_user)
    else
      redirect_to error_path
    end
  end

  def create
    if @user.save
      flash[:success] = 'Added a new user successfully.'
      redirect_to user_profile_path(current_user)
    else
      redirect_to error_path
    end
  end
end
