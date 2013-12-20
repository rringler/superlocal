class FollowersController < ApplicationController
  before_filter :authenticate_user!

  def follow
    followable = params[:type].downcase
                              .capitalize
                              .constantize
                              .where(id: params[:id])
                              .first

    current_user.toggle_following(followable)

    respond_to do |format|
      format.js
    end
  end
end
