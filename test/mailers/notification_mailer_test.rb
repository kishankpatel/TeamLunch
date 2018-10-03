require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "new_place_info_to_manager" do
    mail = NotificationMailer.new_place_info_to_manager
    assert_equal "New place info to manager", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
