class EventPlace < ApplicationRecord
  belongs_to :event
  belongs_to :place
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by", optional: true
  belongs_to :finalizer, :class_name => "User", :foreign_key => "finalized_by", optional: true
end
