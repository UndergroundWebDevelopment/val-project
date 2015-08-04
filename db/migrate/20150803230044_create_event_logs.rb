class CreateEventLogs < ActiveRecord::Migration
  def change
    create_table :event_logs do |t|
      t.integer :channel_id, null: false
      t.string :type, null: false
      t.jsonb :payload
      t.datetime :last_started_processing_at, null: true
      t.datetime :successfully_processed_at, null: true

      t.timestamps null: false
    end

    add_foreign_key :event_logs, :channels, on_delete: :cascade
  end
end
