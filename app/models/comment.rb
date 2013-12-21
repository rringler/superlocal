class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  acts_as_voteable

  has_ancestry

  scope :recent, ->(limit = 10) { order('created_at DESC').limit(limit) }

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :text,    presence: true

  def parent
    Comment.where(id: parent_id).first
  end
end
