class User < ActiveRecord::Base
	devise :database_authenticatable,
				 :confirmable,
				 :recoverable,
				 :registerable,
				 :rememberable,
				 :trackable,
				 :validatable
				 
	attr_accessible :username,
									:email

	validates :username, presence: true,
											 uniqueness: { case_sensitive: false }
	validates :email, presence: true,
										uniqueness: { case_sensitive: false }
end
