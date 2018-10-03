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
    params[:user][:manager_id] = current_user.id
    user = User.new(user_params)
    if user.save
      token = Base64.strict_encode64(user.id.to_s + "-" + user.created_at.to_s)
      user.update_attributes(invitation_token: token) 
      NotificationMailer.send_invitation(user, current_user).deliver
      flash[:success] = "Invitation sent to #{user.name}<#{user.email}>."
      redirect_to users_path
    else
      render 'new'
    end
  end

  def accept_invitation
    id = Base64.strict_decode64(params[:token]).split("-")[0]
    @user = User.find_by_id(id)
    if @user.present?
      if @user.invitation_token.blank? && @user.invitation_accepted_at.present?
        flash[:danger] = "Invitation already accepted, please try signing in." 
        redirect_to login_path 
      end
    else
      flash[:danger] = "User not found!!"
      render request.referrer
    end
  end

  def reset_password
    user = User.find_by_id(params[:id])
    if user.present?
      user.update_attributes(invitation_token: nil, invitation_accepted_at: DateTime.now, password: params[:user][:password], password_confirmation: params[:user][:password])
      flash[:success] = "Invitation accepted, please try signing in." 
    end
    redirect_to login_path 
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :manager_id)
  end
end
