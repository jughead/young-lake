class EventNotificationMailDelivery < ActiveJob::Base
  def perform(event_notification)
    # лишняя проверка не помешает
    return if event_notification.sent?
    return if event_notification.read?
    # TODO: стоит учесть, что параллельно могут быть еще задачи на отправку.
    EventNotification.transaction do
      event_notification.mark_as_sent!
      EventNotificationMailer.send_email(event_notification).deliver_now
    end
  end
end
