class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title
      t.references :user, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.timestamp :start_at, index: true
      t.timestamp :finish_at, index: true

      t.timestamps null: false
    end
  end
end
