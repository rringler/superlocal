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
  acts_as_follower

  has_karma :posts, as: :submitter, weight: [1, 1]
  has_karma :comments, as: :submitter, weight: [1, 1]
  has_many :posts
  has_many :comments
  has_many :votes

  attr_accessor :login

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email,    presence: true, uniqueness: { case_sensitive: false }

  # Voting
  def up_vote(voteable)
    voted_for?(voteable) ? unvote_for(voteable) : vote_exclusively_for(voteable)
  end

  def down_vote(voteable)
    voted_against?(voteable) ? unvote_for(voteable) : vote_exclusively_against(voteable)
  end

  #Following
  def toggle_following(followable)
    following?(followable) ? stop_following(followable) : follow(followable)
  end

  # Override required by Devise to allow username or email for login
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
