class Event < ApplicationRecord
  has_many :event_places
  has_many :places, through: :event_places
  has_many :votes
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by", optional: true

  def finalized_place
    event_places.where(is_finalize: true).first.try(:place).try(:name)
  end

  def finalize_place(place_id, current_user)
    place = Place.find_by_id(place_id)
    if current_user.manager?
      event_places.where(place_id: place_id).first.update_attributes(is_finalize: true, finalized_by: current_user.id)
      begin
        users = User.active_users
        NotificationMailer.finalize_place_info_to_users(place, current_user, users).deliver
        return { message: "#{place.name} has been finalised for team lunch.", type: 'success'}
      rescue Exception => e
        return { message: e.message, type: 'danger' }
      end
    end
  end
end
