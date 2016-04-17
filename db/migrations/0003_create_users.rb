Sequel.migration do 
  up do
    run 'CREATE EXTENSION IF NOT EXISTS pgcrypto;'

    create_table :users do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true

      String :first_name
      String :last_name

      String :email, null: false
      String :password_hash, null: false
    end
    run "CREATE UNIQUE INDEX ON users ((lower(email)))"

    alter_table :profiles do
      add_column :owned_by_user_id, :uuid, null: false
      add_foreign_key [:owned_by_user_id], :users, name: :profile_owned_by_user_fk, on_update: :cascade, on_delete: :cascade
    end
  end

  down do
    alter_table :profiles do
      drop_column :owned_by_user_id
    end

    drop_table :users
  end
end
