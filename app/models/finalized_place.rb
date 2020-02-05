class FinalizedPlace < ApplicationRecord
  belongs_to :event
  belongs_to :place
  belongs_to :finalizer, :class_name => "User", :foreign_key => "finalized_by", optional: true
end
