class NewEventNotificationJob < ActiveJob::Base
  def perform(event)
    message_event = 'event_notifications.new'
    template = 'event_notifications/new'

    # TODO: split jobs?
    EventFilter.matching(event).includes(:user).find_each do |filter|
      event_notification = EventNotification.create(user: filter.user, event: event)
      WebsocketRails.users[filter.user.id].send_message(message_event, {
        html: ApplicationController.renderer.render(
          template: template,
          layout: false,
          assigns: {
            event: event,
            event_notification: event_notification
          }
        ),
        id: event_notification.id
      })
    end
  end
end
