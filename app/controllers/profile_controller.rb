class ProfileController < ApplicationController
  before_action :set_current_user
  def show
    @posts = Post.where(user_id: @current_user.id)
  end
end
