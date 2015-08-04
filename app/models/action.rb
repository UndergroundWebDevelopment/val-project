class Action < ActiveRecord::Base
  belongs_to :operation

  def perform(data_set)
    # No-op for base class!
  end
end
