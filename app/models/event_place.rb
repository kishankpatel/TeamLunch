class EventPlace < ApplicationRecord
  belongs_to :event
  belongs_to :place
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by", optional: true
  belongs_to :finalizer, :class_name => "User", :foreign_key => "finalized_by", optional: true

  def self.finalized_any?(event_id)
    EventPlace.where(event_id: event_id, is_finalize: true).count == 1
  end

end
