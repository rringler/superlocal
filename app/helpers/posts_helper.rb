module PostsHelper
	def display_nested_comments(comments)
		comments.map do |comment, sub_comments|
			render(partial: 'shared/comment', locals: { comment: comment }) + content_tag(:div, display_nested_comments(sub_comments), class: 'nested_comments')
		end.join.html_safe
	end
end
