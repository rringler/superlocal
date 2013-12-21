class BoardDecorator < Draper::Decorator
  delegate_all

  def title_block
    h.content_tag :h2 do
      "#{h.link_to object.title, object} "\
      "#{h.tag "br"} "\
      "#{h.content_tag :small, object.description}".html_safe
    end
  end

  def subscribe_button(params={})
    if h.user_signed_in?
      btn_text  = h.current_user.following?(object) ? 'Unsubscribe' : 'Subscribe'
      btn_class = h.current_user.following?(object) ? 'btn-default' : 'btn-primary'

      params = { type: object.class.to_s.downcase,
                   id: object.id }

      h.link_to "#{btn_text}", h.follow_path(params),
                               id: 'subscribe-button',
                               class: "btn #{btn_class} #{params[:type]}-subscribe-btn",
                               remote: true,
                               method: :post
    end
  end

  def new_post_link
    if h.user_signed_in?
      "#{h.link_to 'Create new post', h.new_board_post_path(object),
                                      id: 'toggle-new-post',
                                      class: 'btn btn-primary',
                                      remote: true} "\
      "#{h.content_tag :div, nil, id: 'new-post-form'}".html_safe
    else
      h.link_to 'Create new post', h.new_user_session_path,
                                   id: 'new-user-session',
                                   class: 'btn btn-primary'
    end
  end

  def recent_posts
    if object.posts.any?
      h.render partial: 'shared/post_summary', collection: object.posts, as: :post
    else
      h.content_tag :p, "We ain't found shit."
    end
  end
end
