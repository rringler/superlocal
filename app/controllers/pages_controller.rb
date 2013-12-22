class PagesController < ApplicationController
  def home
    @recent_posts = Post.recent(5)
  end

  def about
  end

  def contact
  end
end
