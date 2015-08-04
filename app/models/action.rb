class Action < ActiveRecord::Base
  belongs_to :operation
  self.inheritance_column = nil
end
