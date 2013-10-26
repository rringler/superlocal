class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

	has_many :comments

	scope :recent, ->(limit = 10) { order('created_at DESC').limit(limit) }
end
