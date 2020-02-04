class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :voter_id
      t.integer :place_id
      t.integer :event_id

      t.timestamps
    end
    add_index :votes, [:voter_id, :event_id], unique: true
  end
end
