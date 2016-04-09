class EventNotificationMailSender < ActiveJob::Base
  # NOTE: могут несколько запуститься,
  # если одна из них долго работает.
  def perform
    EventNotification.not_sent.find_each do |event_notification|
      EventNotificationMailDelivery.perform_later(event_notification)
    end
  end
end
