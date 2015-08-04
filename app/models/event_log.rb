class EventLog < ActiveRecord::Base
  belongs_to :channel
  self.inheritance_column = nil
end
