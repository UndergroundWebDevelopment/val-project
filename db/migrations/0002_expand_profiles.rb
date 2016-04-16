Sequel.migration do
  up do
    alter_table :profiles do
      add_column :public_description, String, text: true
      add_column :tagline, String
      add_column :date_of_birth, Date
      add_column :public_date_of_birth, FalseClass, default: false

      add_column :slug, String, null: false
      add_index :slug, unique: true

      set_column_not_null :first_name
    end
  end

  down do
    alter_table :profiles do
      set_column_allow_null :first_name
      drop_column :slug
      drop_column :public_date_of_birth
      drop_column :date_of_birth
      drop_column :tagline
      drop_column :public_description
    end
  end
end
