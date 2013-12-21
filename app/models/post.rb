class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  acts_as_voteable

  has_many :comments

  attr_accessor :parent

  scope :recent, ->(limit = 10) { order('created_at DESC').limit(limit) }

  validates :title,    presence: true, length: { maximum: 255 }
  validates :user_id,  presence: true
  validates :board_id, presence: true
end
