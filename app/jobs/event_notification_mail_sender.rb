class EventNotificationMailSender < ActiveJob::Base
  # TODO: могут несколько запуститься,
  # если одна из них долго работает.
  def perform
    EventNotification.not_sent.created_before(15.minutes.ago).find_each do |event_notification|
      EventNotificationMailDelivery.perform_later(event_notification)
    end
  end
end
