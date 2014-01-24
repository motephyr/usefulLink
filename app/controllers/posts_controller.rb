class PostsController < ApplicationController
  before_action :login_required, :only => [:new, :create, :edit,:update,:destroy,:create_comment]

  def index
    @posts = Post.recent.limit(10)

    set_page_title "連結列表"
    set_page_description descriptions = @posts.map {|x| x.description}.join(",") # or @article.content.truncate(100)
    set_page_keywords    titles = @posts.map {|x| x.title}.join(",")
  end

  def gem
    #category = Category.where(:name => "Gem")
    @posts = Post.joins( :categories ).where(:categories => {:name => "Gem"})
    render :index
  end

  def news
    @posts = Post.joins( :categories ).where(:categories => {:name => "新聞"})
    render :index
  end

  def discuss
    @posts = Post.joins( :categories ).where(:categories => {:name => "討論"})
    render :index
  end

  def teach
    @posts = Post.joins( :categories ).where(:categories => {:name => "教學"})
    
    respond_to do |format|
      format.html { render :index } # show.html.erb
      format.json { render :json => @posts.to_json }
    end
  end

  def ajax
    @posts = Post.recent.limit(10)
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    set_page_title       @post.title   # same as <title> tag
    set_page_description @post.description # or @article.content.truncate(100)
    set_page_keywords    category = @post.categories.map {|x| x.name}.join(",")    # or @article.keywords

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
    @post = current_user.posts.build(post_params)

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
      
      PostMailerService.new().send_email_to_other_people(@post,comment)

      redirect_to post_path(@post)
    else
      render :show
    end
  end

  def feed
    @posts = Post.all(:select => "title, id, description, created_at", :order => "created_at DESC", :limit => 20)

    respond_to do |format|
      format.html
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  private
  # TODO
  def post_params
    params.require(:post).permit(:url)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

  # def url_check_http
  #   url = params[:post][:url]
  #   if !(url.include?("http://") || url.include?("https://"))
  #     flash[:warning] = "連結請加入http:// or https://"
  #     redirect_to new_post_path
  #   end
  # end

  # def url_check_the_same_link
  #   url = params[:post][:url]
  #   if !Post.where(:url => url ).empty?
  #     flash[:warning] = "已有重複的連結"
  #     redirect_to new_post_path
  #   end
  # end
end
