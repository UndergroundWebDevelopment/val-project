class Channel < ActiveRecord::Base
  has_many :event_logs
  self.inheritance_column = nil
end
