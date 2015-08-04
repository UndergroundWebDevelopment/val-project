class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.references :operation, index: true, foreign_key: true, null: false

      t.string :operator_field_name, null: false
      t.string :operator, null: false
      t.string :operand_field_name
      t.string :operand_value
      t.string :data_type, null: false

      t.timestamps null: false
    end
  end
end
