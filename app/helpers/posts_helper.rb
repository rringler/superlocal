module PostsHelper
	def display_nested_comments(comments)
		comments.map do |comment, sub_comments|
			content_tag(:div, render(partial: 'shared/comment', locals: { comment: comment }) + 
												display_nested_comments(sub_comments),
												class: 'nested_comment well')
		end.join.html_safe
	end
end
