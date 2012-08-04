class Tag < ActiveRecord::Base
  attr_accessible :location, :lat, :lng, :text, :topic_id
  belongs_to :topic

  validates :lat, presence: true
  validates :lng, presence: true
  validates :text, presence: true, length: { maximum: 140 }
  validates :topic_id, presence: true
  validates :location, presence: true
end
