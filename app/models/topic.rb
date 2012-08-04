class Topic < ActiveRecord::Base
  attr_accessible :name, :creator_id
  has_many :tags, dependent: :destroy
  belongs_to :creator, class_name: 'User'
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :creator_id, presence: true
end
