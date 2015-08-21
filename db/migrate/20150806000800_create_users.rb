class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.jsonb :auth_meta_data

      # Add an index for quick lookup by email (for sign in) and also to
      # enforce uniqueness... only one user per email in the table!
      t.index :email, unique: true
    end
  end
end
