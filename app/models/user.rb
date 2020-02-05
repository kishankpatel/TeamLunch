class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  has_many :votes, :foreign_key => "voter_id", :class_name => "Vote"
  
  scope :active_users, -> { where("manager_id is NOT NULL AND invitation_token IS NULL AND invitation_accepted_at IS NOT NULL") }
  before_validation :set_password, on: :create

  def set_password
    self.password = SecureRandom.hex if self.password.blank?
  end

  def manager
    User.find(manager_id)
  end
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def manager?
    self.manager_id == nil
  end

  def role
    if manager?
      'Manager'
    else
      'Employee'
    end
  end

  def send_invitation(manager)
    token = Base64.strict_encode64(id.to_s + "-" + created_at.to_s)
    update_attributes(manager_id: manager.id,invitation_token: token) 
    NotificationMailer.send_invitation(self, manager).deliver
  end

  def self.validate_invitation(token)
    begin
      id = Base64.strict_decode64(token).split("-")[0]
      user = User.find_by_id(id)
      response = { user: user }
      if user.present?
        if user.invitation_token.blank? && user.invitation_accepted_at.present?
          response = { error_message: "Invitation already accepted, please try signing in."}
        end
      else
        response = { error_message: "User not found!!"}
      end
    rescue Exception => e
      response = { error_message: e.message}
    end
    return response
  end

  def self.reset_password(params, request)
    user = User.find_by_id(params[:id])
    
    if user.present? 
      if params[:user][:password] == params[:user][:password_confirmation]
        user.update_attributes(invitation_token: nil, invitation_accepted_at: DateTime.now, password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        response = { type: 'notice', message: 'Invitation accepted, please try signing in.', path: 'login' }
      else
        response = { type: 'danger', message: 'Password and confirm password does not matched.', path: 'referrer' }
      end
    else
      response = { type: 'danger', message: 'User not found!', path: 'login' }
    end

    return response
  end

end
