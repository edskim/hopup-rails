class Topic < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :tags, dependent: :destroy
  belongs_to :user
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :user_id, presence: true
end
