class PostDecorator < Draper::Decorator
  delegate_all

  def sub_title
    "submitted #{h.time_ago_in_words(object.created_at)} ago "\
    "by #{h.link_to object.user.username, object.user}".html_safe
  end

  def comments_block
    if object.comments.any?
      h.display_nested_comments(object.comments.arrange(order: :created_at))
    end
  end
end
