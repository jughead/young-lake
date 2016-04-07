class AddUserIdToEventFilters < ActiveRecord::Migration
  def change
    add_reference :event_filters, :user, index: true, foreign_key: true
  end
end
