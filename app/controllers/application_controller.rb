class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Please login to continue!!"
      redirect_to login_path
    end
  end
  def check_login
    if logged_in?
      flash[:danger] = "You are already signed in."
      redirect_to root_path
    end
  end
  def is_manager
    unless current_user.is_manager?
      flash[:danger] = "You don't have rights access to view this page."
      redirect_to root_path
    end
  end
end
