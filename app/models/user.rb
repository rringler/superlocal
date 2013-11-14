class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
  			 :confirmable,
  			 :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  acts_as_voter

  has_karma :posts, as: :submitter, weight: [1, 1]
  has_karma :comments, as: :submitter, weight: [1, 1]
  has_many :posts
  has_many :comments
  has_many :votes
				 
	attr_accessor :login

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email,    presence: true, uniqueness: { case_sensitive: false }


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
