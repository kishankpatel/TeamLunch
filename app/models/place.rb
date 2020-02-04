class Place < ApplicationRecord
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by", optional: true
  validates :name, presence: true
  validates :address, presence: true
  has_many :event_places
  has_many :events, through: :event_places
  has_many :votes

  scope :approved_places, -> { where(is_approved: true) }

  def event_voters(event_id)
    user_ids = votes.where(event_id: event_id).pluck(:voter_id)
    User.where("id IN (?)", user_ids).pluck(:name).join(", ")
  end

  def finalized?(event_id)
    event_places.where(event_id: event_id).first.try(:is_finalize)
  end

end
