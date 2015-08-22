require "trailblazer/operation/representer"

class Action < ActiveRecord::Base
  # The Action::Process operation handles executing a specific action against a
  # specific data set. It tracks meta-data about the action's execution (start
  # time, status, etc) in the ActionLog model.
  class Process < Trailblazer::Operation

    def process(model, data_set)
      @action_log = ActionLog.create(
        action: model, 
        payload: data_set, 
        last_started_processing_at: Time.now
      )

      # Specific logic to process the different kinds of actions (or more
      # likely to choose a subclass based on type and/or other factors) will
      # eventually go here.
      

      # Update the action_log with the time it was successfully
      # processed at.
      @action_log.update(successfully_processed_at: Time.now)
    end

    def action_log
      @action_log
    end
  end
end
