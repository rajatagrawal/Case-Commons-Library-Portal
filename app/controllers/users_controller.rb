class UsersController< ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id]).destroy
  end

  def update
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = params[:user]
    @user.save!
  end

  def profile
    @user = User.find(params[:id])
  end
end
