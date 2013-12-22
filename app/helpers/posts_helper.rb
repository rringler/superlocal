module PostsHelper
  def display_nested_comments(comments)
    comments.map do |comment, sub_comments|
      content_tag(:div, class: 'nested-comment') do
        "#{render partial: 'shared/comment_detail', locals: { comment: comment }} "\
        "#{display_nested_comments(sub_comments)}".html_safe
      end
    end.join.html_safe
  end
end
