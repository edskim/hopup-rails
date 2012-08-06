class Hit < ActiveRecord::Base
  attr_accessible :lat, :lng, :requester_id, :tag_id
  belongs_to :requester, class_name: 'User'
  belongs_to :tag

  validates :lat, presence: true
  validates :lng, presence: true
  validates :requester_id, presence: true
  validates :tag_id, presence: true
end
