class Board < ActiveRecord::Base
	acts_as_followable
	
	has_many :posts

	validates :slug, presence: true, uniqueness: { case_sensitive: false }
end
