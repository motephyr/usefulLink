class PostsController < ApplicationController
  before_action :login_required, :only => [:new, :create, :edit,:update,:destroy,:create_comment]

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

    comments = @post.comments.recent.limit(10)
    @comment = Comment.new
  end

  def create_comment
    @post = Post.find(params[:id])
    comment = @post.comments.create(comment_params)
    comment.author = current_user
    comment.save
    
    redirect_to post_path(@post)
  end

  def post_params
    params.require(:post).permit(:url)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
