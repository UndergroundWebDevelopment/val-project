Sequel.migration do 
  change do
    run 'CREATE EXTENSION "uuid-ossp"'

    create_table :profiles do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true

      String :first_name
      String :last_name
    end
  end
end
