class CreateEventNotifications < ActiveRecord::Migration
  def change
    create_table :event_notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.timestamp :sent_at, index: true
      t.boolean :is_read
      t.timestamp :created_at, index: true
    end
    add_index :event_notifications, :sent_at, where: 'sent_at IS NULL', name: :index_event_notifications_on_sent_at_null
  end
end
