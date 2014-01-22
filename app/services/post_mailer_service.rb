class PostMailerService
  def initialize
  end

  #取得應收到訊息的email list
  #去掉重覆的和自已的
  def get_must_send_emails_list(post,comment)
      emails = post.comments.map{ |x| x.author.email}
      emails_add_posts = emails + [post.author.email]
      uniq_emails = emails_add_posts.uniq{|x| x}
      uniq_emails_delete_self = uniq_emails - [comment.author.email]
  end
end