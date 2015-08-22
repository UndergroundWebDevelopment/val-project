class AddUserAssociations < ActiveRecord::Migration
  def change
    add_column :channels, :user_id, :integer, null: false
    add_foreign_key :channels, :users

    add_column :operations, :user_id, :integer, null: false
    add_foreign_key :operations, :users
  end
end
