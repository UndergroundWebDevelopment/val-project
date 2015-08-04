class Operation < ActiveRecord::Base
  has_many :conditions
  has_many :actions

  class << self
    def with_conditions
      includes(:conditions)
    end

    def with_actions
      includes(:actions)
    end

    def with_event_type(type)
      where(event_type: type)
    end
  end

  # NOTE: This method may be expanded in the future to include
  # other data sources which should be considered as part of the
  # operation's data set. For now just the event's payload.
  def data_set_for_event(event)
    event.payload
  end
end
