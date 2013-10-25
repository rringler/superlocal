class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

	has_many :comments
	has_many :votes

	acts_as_commentable
end
