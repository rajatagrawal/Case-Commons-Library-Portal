class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def welcome

  end

  def after_sign_in_path_for(resource)
    profile_path(resource)
  end
end
