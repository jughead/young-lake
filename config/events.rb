WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.
  namespace :event_notifications do
    subscribe :mark_as_read, to: EventNotificationsController, with_method: :mark_as_read
    subscribe :mark_as_unread, to: EventNotificationsController, with_method: :mark_as_unread
    subscribe :destroy, to: EventNotificationsController, with_method: :destroy

    subscribe :index, to: EventNotificationsController, with_method: :index
  end
end
