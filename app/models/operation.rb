class Operation < ActiveRecord::Base
  has_many :conditions
  has_many :actions
end
