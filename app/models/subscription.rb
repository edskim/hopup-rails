class Subscription < ActiveRecord::Base
  attr_accessible :topic_id, :user_id
  belongs_to :user
  belongs_to :topic

  validates :topic_id, presence: true
  validates :user_id, presence: true
end
