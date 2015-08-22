class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :event_logs
  self.inheritance_column = nil
end
