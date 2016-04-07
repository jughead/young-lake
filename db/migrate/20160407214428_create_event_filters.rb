class CreateEventFilters < ActiveRecord::Migration
  def change
    create_table :event_filters do |t|
      t.timestamp :start_at_from, index: true
      t.timestamp :start_at_to, index: true
      t.references :theme, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
    end
  end
end
