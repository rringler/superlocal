class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

	acts_as_voteable

	has_many :comments

	scope :recent, ->(limit = 10) { order('created_at DESC').limit(limit) }

	validates :title, presence: true, length: { maximum: 255 }
end
