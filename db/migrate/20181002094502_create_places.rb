class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.integer :created_by, null: false
      t.boolean :is_approved, default: false

      t.timestamps
    end
  end
end
