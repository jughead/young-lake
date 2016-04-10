dispatcher = new WebSocketRails(location.hostname + (if location.port then ':' + location.port else '') + '/websocket');

window.Meyvn ||= {}
window.Meyvn.Notifications = class Notifications
  @mainContainer: () ->
    @_main_container ||= $('#main-column')

  @notificationColumn: () ->
    @_notification_column ||= $('#notification-column')

  @notificationContainer: () ->
    @_notification_container ||= @notificationColumn().find('.js-notification-list')

  @notification: (id) ->
    $('#event-notification-' + id)

  @markAsRead: (id) ->
    @notification(id).removeClass('notification-unread').addClass('notification-read')
    # TODO: change button text and behavior
    @updateCount()

  @markAsUnread: (id) ->
    @notification(id).removeClass('notification-read').addClass('notification-unread')
    # TODO: change button text and behavior
    @updateCount()

  @loadData: (data, replace = false) ->
    if replace
      @notificationContainer().empty()
    @notificationContainer().append(data.html)
    @updateCount()

  @remove: (id) ->
    @notification(id).remove()
    @updateCount()

  @show: () ->
    @mainContainer().removeClass('col-md-12').addClass('col-md-9')
    @notificationColumn().removeClass('hide').addClass('col-md-3')

  @hide: () ->
    @mainContainer().removeClass('col-md-9').addClass('col-md-12')
    @notificationColumn().addClass('hide').removeClass('col-md-3')

  @updateCount: () ->
    count = @notificationContainer().find('.notification-unread').length
    if count == 0
      count = ''
    else
      count = '(' + count + ')'
    $('.js-open-notifications .js-notification-count').text(count)

  @reload: () ->
    @_main_container = null
    @_notification_container = null
    @_notification_column = null
    @notificationContainer().on 'click', '.js-delete-notification', (event) ->
      dispatcher.trigger('event_notifications.destroy', {id: $(this).closest('.notification').data('id')})

    @notificationContainer().on 'click', '.js-mark-as-unread-notification', (event) ->
      dispatcher.trigger('event_notifications.mark_as_unread', {id: $(this).closest('.notification').data('id')})

    @notificationContainer().on 'click', '.js-mark-as-read-notification', (event) ->
      dispatcher.trigger('event_notifications.mark_as_read', {id: $(this).closest('.notification').data('id')})

  @register: () ->
    $(document).on 'click', '.js-close-notifications', (event) ->
      Notifications.hide()
    $(document).on 'click', '.js-open-notifications', (event) ->
      Notifications.show()

destroyAction = (data) ->
  Notifications.remove(data.id)

newAction = (data) ->
  Notifications.loadData(data)

load = (data) ->
  Notifications.loadData(data, true)

markAsRead = (data) ->
  Notifications.markAsRead(data.id)

markAsUnread = (data) ->
  Notifications.markAsUnread(data.id)

processError = (data) ->
  console.log 'Error occured', data

dispatcher.bind 'event_notifications.mark_as_read_error', processError
dispatcher.bind 'event_notifications.mark_as_unread_error', processError
dispatcher.bind 'event_notifications.destroy_error', processError
dispatcher.bind 'event_notifications.index_error', processError
dispatcher.bind 'event_notifications.index_success', load
dispatcher.bind 'event_notifications.destroy_success', destroyAction
dispatcher.bind 'event_notifications.mark_as_read_success', markAsRead
dispatcher.bind 'event_notifications.mark_as_unread_success', markAsUnread
dispatcher.bind 'event_notifications.new', newAction
Notifications.register()

$(document).on 'page:load ready', () ->
  Notifications.reload()
  dispatcher.trigger('event_notifications.index')
