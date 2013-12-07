class UsersController< ApplicationController
  load_and_authorize_resource

  def destroy
    @user = User.find(params[:id]).destroy
  end

  def update
    @user = User.find(params[:id])
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
