class CreateActionLogs < ActiveRecord::Migration
  def change
    create_table :action_logs do |t|
      t.references :action, index: true, foreign_key: true, null: false
      t.jsonb :payload
      t.datetime :last_started_processing_at, null: true
      t.datetime :successfully_processed_at, null: true

      t.timestamps null: false
    end
  end
end
