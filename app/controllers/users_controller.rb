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
    binding.pry
    @user = User.create(params[:user])
  end
end
