Sequel.migration do 
  up do
    create_table :sessions do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      column :owned_by_user_id, :uuid, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :last_seen_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      foreign_key [:owned_by_user_id], :users, name: :session_owned_by_user_fk, on_update: :cascade, on_delete: :cascade
    end
  end

  down do
    drop_table :sessions
  end
end
