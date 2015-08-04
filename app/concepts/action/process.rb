require "trailblazer/operation/representer"

class Action < ActiveRecord::Base
  # The Process operation handles new event_log records that are created by
  # webhooks. It is responsible for attempting to match and execute this
  # event_log against candidate operations, and then marking the event_log
  # record as processed when this has been done.
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
