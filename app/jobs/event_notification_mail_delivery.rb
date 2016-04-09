class EventNotificationMailDelivery < ActiveJob::Base
  def perform(event_notification)
    # лишняя проверка не помешает
    return if event_notification.sent?
    return if event_notification.read?
    # TODO: наверное надо проверить, что параллельно нет еще задач на отправку.
    EventNotificationMailer.send_email(event_notification).deliver_now
    event_notification.mark_as_sent
  end
end
