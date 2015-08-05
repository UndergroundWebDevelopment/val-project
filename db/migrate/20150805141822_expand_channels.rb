class ExpandChannels < ActiveRecord::Migration
  def change
    change_table :channels do |t|
      t.string :type
      t.string :oauth_token
      t.string :local_api_key
    end
  end
end
