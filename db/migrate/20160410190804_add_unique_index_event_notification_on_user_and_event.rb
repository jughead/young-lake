class AddUniqueIndexEventNotificationOnUserAndEvent < ActiveRecord::Migration
  def change
    add_index :event_notifications, [:user_id, :event_id], unique: true
  end
end
