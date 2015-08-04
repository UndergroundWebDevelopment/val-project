class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name, null: false
      t.text :description
      t.integer :operation_id, null: false
      t.string :type, null: false
      t.jsonb :field_mappings

      t.timestamps null: false
    end

    add_foreign_key :actions, :operations, on_delete: :cascade
  end
end
