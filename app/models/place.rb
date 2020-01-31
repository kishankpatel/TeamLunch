class Place < ApplicationRecord
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by", optional: true
  validates :name, presence: true
  validates :address, presence: true
  has_many :event_places
  has_many :events, through: :event_places
end
