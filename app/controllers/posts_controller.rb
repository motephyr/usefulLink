class PostsController < ApplicationController
  before_action :login_required, :only => [:new, :create, :edit,:update,:destroy,:create_comment]

  def index
    @page_title = "首頁"
    @posts = Post.all.recent.limit(10)
  end

  def gem
    @posts = Post.joins( :categories ).where("categories.name = 'Gem' ")
    render :index
  end

  def news
    @posts = Post.joins( :categories ).where("categories.name = '新聞' ")
    render :index
  end

  def discuss
    @posts = Post.joins( :categories ).where("categories.name = '討論' ")
    render :index
  end

  def teach
    @posts = Post.joins( :categories ).where("categories.name = '教學' ")
    render :index
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])

    #點擊數+1
    Post.increment_counter(:click_count, params[:id])

    comments = @post.comments.recent.limit(10)
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy

    redirect_to posts_path
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    #設定類別
    c = Category.where( :name => params[:category])
    @post.categories << c

    if @post.save

      redirect_to posts_path
    else
      render :new
    end
  end

  def create_comment
    @post = Post.find(params[:id])
    comment = @post.comments.create(comment_params)
    comment.author = current_user
    if comment.save
      #取得所有人的email 去掉重覆的和自已的
      emails = @post.comments.map{ |x| x.author.email}
      emails_add_posts = emails + [@post.author.email]
      uniq_emails = emails_add_posts.uniq{|x| x}
      uniq_emails_delete_self = uniq_emails - [comment.author.email]

      PostMailer.sendmessage(uniq_emails_delete_self,@post, comment.comment).deliver
      redirect_to post_path(@post)
    else
      render :action => :show
    end
  end

  def feed
    @posts = Post.all(:select => "title, id, description, created_at", :order => "created_at DESC", :limit => 20)

    respond_to do |format|
      format.html
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  def post_params
    params.require(:post).permit(:url)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
