class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def confirm(email,content)
    @message = content
    mail to: email , subject: "留言"
  end
end
