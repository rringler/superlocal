class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

  has_ancestry

  scope :recent, ->(limit = 10) { order('created_at DESC').limit(limit) }

  validates :text, presence: true
end
