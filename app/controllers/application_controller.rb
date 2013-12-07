class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to controller: :application, action: :error
  end

  def welcome
    if user_signed_in?
      redirect_to homepage_path
    end

  end

  def after_sign_in_path_for(resource)
    user_profile_path(resource)
  end
end
