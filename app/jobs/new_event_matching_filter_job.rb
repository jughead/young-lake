class NewEventMatchingFilterJob < ActiveJob::Base
  def perform(user, event)
    event_notification = EventNotification.where(user: user, event: event).first_or_initialize
    return if event_notification.persisted?
    event_notification.save!
    # NOTE: не уверен, что это не генерит exception-ы
    # ну если генерит и не уведомили пользователя - он походит по сайту и получит обновление сам
    WebsocketRails.users[user.id].send_message('event_notifications.new', {
        html: ApplicationController.renderer.render(
          template: 'event_notifications/new',
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
