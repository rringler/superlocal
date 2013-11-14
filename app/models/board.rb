class Board < ActiveRecord::Base
	has_many :posts

	validates :slug, presence: true, uniqueness: { case_sensitive: false }
end
