Sequel.migration do 
  up do
    alter_table :users do
      drop_column :first_name
      drop_column :last_name
    end
  end

  down do
    alter_table :users do
      add_column :first_name, String
      add_column :last_name, String
    end
  end
end
