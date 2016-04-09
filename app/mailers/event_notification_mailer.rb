class EventNotificationMailer < ActionMailer::Base
  layout 'mailer'
  def send_email(event_notification)
    @event_notification = event_notification
    @event = event_notification.event
    @user = event_notification.user
    mail(to: @user.email)
  end
end
