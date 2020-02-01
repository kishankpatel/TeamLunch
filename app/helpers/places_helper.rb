module PlacesHelper

  def voted_event?(event_id)
    current_user.votes.where(event_id: event_id).count > 0
  end
end
