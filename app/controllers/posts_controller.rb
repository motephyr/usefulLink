class PostsController < ApplicationController

  def index
  	@page_title = "首頁"
  	@posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.author = current_user
  	if @post.save
  		redirect_to posts_path
  	else
  		render :new
  	end
  end

  def show
  	@post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url,:title,:content)
  end
end
