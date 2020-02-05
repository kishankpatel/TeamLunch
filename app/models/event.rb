class Event < ApplicationRecord
  has_and_belongs_to_many :places
  has_many :votes
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by", optional: true
  has_one :finalized_place
  
  def finalized_place_name
    finalized_place.try(:place).try(:name)
  end

  def any_finalized_place?
    finalized_place.present?
  end

  def finalized?(place_id)
    finalized_place.try(:place_id) == place_id
  end

  def finalize_place(place_id, current_user)
    place = Place.find_by_id(place_id)
    ability = Ability.new(current_user)
    if ability.can? :finalize_place, Event
      FinalizedPlace.create(place_id: place_id, event_id: id, finalized_by: current_user.id)
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
