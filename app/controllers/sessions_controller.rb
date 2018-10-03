class SessionsController < ApplicationController
  before_action :check_invitation, only: [:create]
  before_action :check_login, only: [:new]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'Signed in successfully.'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
  	flash[:success] = 'Signed out successfully.'
    redirect_to login_path
  end

  def check_invitation
    user = User.find_by(email: params[:session][:email].downcase)
    if user.present? && user.invitation_token.present? && user.invitation_accepted_at.blank?
      flash[:danger] = "Please accept invitation to continue."
      redirect_to login_path
    end
  end
end
