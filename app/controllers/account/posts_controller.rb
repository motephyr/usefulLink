class Account::PostsController < ApplicationController
  before_action :login_required
  def index
    @posts = current_user.posts.page(params[:page]).per(10)
  end
end
