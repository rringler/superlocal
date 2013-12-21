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

      h.form_tag h.follow_path, method: :post, remote: true do
        "#{h.hidden_field_tag 'type', object.class.to_s.downcase} "\
        "#{h.hidden_field_tag 'id', object.id} "\
        "#{h.submit_tag btn_text, class: "btn
                                        #{btn_class}
                                        #{object.class.to_s.downcase}-subscribe-btn
                                          pull-right",
                                  id: 'subscribe-button' }".html_safe
      end
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
