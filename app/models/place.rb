class Place < ApplicationRecord
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  validates :name, presence: true
  validates :address, presence: true
end
