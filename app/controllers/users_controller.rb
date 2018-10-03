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
      token = Base64.strict_encode64(user.id.to_s + "-" + user.created_at.to_s)
      user.update_attributes(manager_id: current_user.id,invitation_token: token) 
      NotificationMailer.send_invitation(user, current_user).deliver
      flash[:success] = "Invitation sent to #{user.name}<#{user.email}>."
      redirect_to users_path
    else
      flash[:danger] = user.errors.messages
      render 'new'
    end
  end

  def accept_invitation
    begin
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
    rescue Exception => e
      flash[:danger] = e.message
      redirect_to login_path 
    end
  end

  def reset_password
    user = User.find_by_id(params[:id])
    if user.present? 
      if params[:user][:password] == params[:user][:password_confirmation]
        user.update_attributes(invitation_token: nil, invitation_accepted_at: DateTime.now, password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        flash[:success] = "Invitation accepted, please try signing in." 
      else
        flash[:danger] = "Password and password confirmation does not matched."
        redirect_to request.referrer
        return
      end
    else
      flash[:danger] = "Failed to reset password."
    end
    redirect_to login_path 
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
