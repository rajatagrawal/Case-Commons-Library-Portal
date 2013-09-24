class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

rescue_from CanCan::AccessDenied do |exception|
redirect_to controller: :books , action: :error
end

  def welcome

  end

  def after_sign_in_path_for(resource)
    profile_path(resource)
  end

  def error

  end
end
