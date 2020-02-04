class Vote < ApplicationRecord
  belongs_to :voter, :foreign_key => "voter_id", :class_name => "User", optional: true
  belongs_to :place
  belongs_to :event
  validates :event_id, presence: true, uniqueness: { scope: :voter_id, message: "You can't vote twice" }
end
