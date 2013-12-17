class UserDecorator < Draper::Decorator
  delegate_all

  def recent_posts
    object.posts.recent
  end

  def recent_comments
    object.comments.recent
  end
end
