class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_accepted_at, :datetime
    add_index :users, :invitation_token, unique: true
  end
end
