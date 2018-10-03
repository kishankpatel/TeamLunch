class NotificationMailer < ApplicationMailer

  def new_place_info_to_manager(place, manager, user)
    @manager = manager
    @place = place
    @user = user
    mail to: manager.email, subject: "New place proposed by #{@user.name} for team lunch"
  end

  def finalize_place_info_to_users(place, manager, users)
    @manager = manager
  	@place = place
    mail to: users.pluck(:email), subject: "Place finalized for team lunch"
  end

  def send_invitation(user,manager)
    @manager = manager
    @user = user
    mail to: user.email, subject: "Invitation to join team lunch"
  end
end
