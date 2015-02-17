class Message < ActiveRecord::Base
  after_create :send_notification

  def send_notification
    SiteMailer.new_message(self)
  end
end
