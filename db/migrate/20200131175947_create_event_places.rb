class CreateEventPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :event_places do |t|
      t.integer :event_id
      t.integer :place_id
      t.boolean :is_finalize, default: false
      t.integer :finalized_by

      t.timestamps
    end
  end
end
