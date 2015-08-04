class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name, null: false
      t.text :description
      t.references :operation, index: true, foreign_key: true, null: false
      t.string :type, null: false
      t.jsonb :field_mappings

      t.timestamps null: false
    end
  end
end
