require 'test_helper'

class PostMailerTest < ActionMailer::TestCase
  test "sendmessage" do
    mail = PostMailer.sendmessage
    assert_equal "Confirm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
  
  test "send_order_mail_by_hot" do
    mail = PostMailer.send_order_mail_by_hot
    assert_equal "Send order mail by hot", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
