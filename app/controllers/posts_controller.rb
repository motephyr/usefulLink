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
        comments = @post.comments.create(:title => "First comment.", :comment => "This is the first comment.", :author => current_user)
  		redirect_to posts_path
  	else
  		render :new
  	end
  end

  def show
  	@post = Post.find(params[:id])

    comments = @post.comments.recent.limit(10)
  end

  def post_params
    params.require(:post).permit(:url,:title,:content)
  end
end
