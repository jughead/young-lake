class EventNotificationsController < WebsocketRails::BaseController
  before_action :authenticate_user!

  def index
    # TODO: pagination
    begin
      event_notifications = current_user.event_notifications.includes(:event)

      html = ''.html_safe
      event_notifications.each do |event_notification|
        html << render_to_string(
          template: 'event_notifications/new',
          layout: false,
          assigns: {event_notification: event_notification, event: event_notification.event})
      end

      send_message :index_success, {html: html, count: event_notifications.count}, namespace: :event_notifications
    rescue => e
      send_message :index_error, {error: e.to_s}, namespace: :event_notifications
    end
  end

  def mark_as_read
    @event_notification = current_user.event_notifications.find_by(id: message[:id])
    if @event_notification && @event_notification.mark_as_read
      send_message :mark_as_read_success, {id: @event_notification.id}, namespace: :event_notifications
    else
      send_message :mark_as_read_error, {id: @event_notification.id}, namespace: :event_notifications
    end
  end

  def mark_as_unread
    @event_notification = current_user.event_notifications.find_by(id: message[:id])
    if @event_notification && @event_notification.mark_as_unread
      send_message :mark_as_unread_success, {id: @event_notification.id}, namespace: :event_notifications
    else
      send_message :mark_as_unread_error, {id: @event_notification.id}, namespace: :event_notifications
    end
  end

  def destroy
    @event_notification = current_user.event_notifications.find_by(id: message[:id])
    if @event_notification && @event_notification.destroy
      send_message :destroy_success, {id: @event_notification.id}, namespace: :event_notifications
    else
      send_message :destroy_error, {}, namespace: :event_notifications
    end
  end
end
