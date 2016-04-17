Sequel.migration do 
  up do
    create_table :access_tokens do
      String :token, null: false
      index :token, unique: true
      column :user_id, :uuid, null: false
      foreign_key [:user_id], :users, name: :access_token_owned_by_user_fk, on_update: :cascade, on_delete: :cascade
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
    end
  end

  down do
    drop_table :access_tokens
  end
end
