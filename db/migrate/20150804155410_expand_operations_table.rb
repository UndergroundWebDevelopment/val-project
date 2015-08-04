class ExpandOperationsTable < ActiveRecord::Migration
  def change
    change_table :operations do |t|
      t.string :event_type, null: false
    end
  end
end
