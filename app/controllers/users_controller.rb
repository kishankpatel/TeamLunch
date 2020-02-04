class UsersController < ApplicationController
  before_action :authenticate_user, except: [:accept_invitation, :reset_password]
  before_action :is_manager, except: [:accept_invitation, :reset_password]
  before_action :check_login, only: [:accept_invitation, :reset_password]
  def index
    @users = User.all.where("id != ?", current_user.id)
  end
  
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      user.send_invitation(current_user)
      flash[:success] = "Invitation sent to #{user.name}(#{user.email})."
      redirect_to users_path
    else
      flash[:danger] = user.errors.messages
      render 'new'
    end
  end

  def accept_invitation
    response = User.validate_invitation(params[:token])
    if response[:error_message].present?
      flash[:danger] = response[:error_message]
      redirect_to login_path
    else
      @user = response[:user]
    end
  end

  def reset_password
    response = User.reset_password(params, request)
    flash[response[:type]] = response[:message]
    redirect_to response[:path] == 'login' ? login_path : request.referrer
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
