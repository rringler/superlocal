class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

	has_many :comments
end
