class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.integer :operation_id, null: false

      t.string :operator_field_name, null: false
      t.string :operator, null: false
      t.string :operand_field_name
      t.string :operand_value
      t.string :data_type, null: false

      t.timestamps null: false
    end

    add_foreign_key :conditions, :operations, on_delete: :cascade
  end
end
