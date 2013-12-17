class UserDecorator < Draper::Decorator
  delegate_all

  def recent_posts
    object.posts.recent
  end

  def recent_comments
    object.comments.recent
  end

  # Draper appears to have some issue delegating dynamic methods to the
  # decorated object.
  def following_boards
    object.following_boards
  end
end