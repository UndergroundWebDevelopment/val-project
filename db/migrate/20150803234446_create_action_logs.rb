class CreateActionLogs < ActiveRecord::Migration
  def change
    create_table :action_logs do |t|
      t.integer :action_id, null: false
      t.jsonb :payload
      t.datetime :last_started_processing_at, null: true
      t.datetime :successfully_processed_at, null: true

      t.timestamps null: false
    end

    add_foreign_key :action_logs, :actions, on_delete: :cascade
  end
end
