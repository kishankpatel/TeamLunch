class CreateFinalizedPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :finalized_places do |t|
      t.integer :event_id
      t.integer :place_id
      t.integer :finalized_by

      t.timestamps
    end
  end
end
