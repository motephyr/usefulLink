class PostMailer < ActionMailer::Base
  default from: "admin@usefullink.herokuapp.com"

  def sendmessage(email,post,content)
    @message = content
    mail to: email , subject: '關於' + post.title
  end

  def send_order_mail_by_hot
    @posts = Post.all.hot.limit(10)
    User.all.each do |user|
      mail to: user.email , subject: '本週快訊'
    end
  end
end
