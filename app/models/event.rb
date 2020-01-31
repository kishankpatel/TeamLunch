class Event < ApplicationRecord
  has_many :event_places
  has_many :places, through: :event_places
  has_many :votes
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by", optional: true
end
