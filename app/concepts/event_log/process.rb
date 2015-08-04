require "trailblazer/operation/representer"

class EventLog < ActiveRecord::Base
  # The Process operation handles new event_log records that are created by
  # webhooks. It is responsible for attempting to match and execute this
  # event_log against candidate operations, and then marking the event_log
  # record as processed when this has been done.
  class Process < Trailblazer::Operation
    include Responder
    model ::EventLog, :update

    builds do |params|
      JSON if params[:format] == "json"
    end

    contract do
      # Empty contract, Process _just_ works with the existing model.
    end

    class JSON < self
      include Representer

      representer do
        include Roar::JSON
      end
    end

    def process(_)
      # Update the model (event) with the time we started processing it. This
      # helps us differentiate between events waiting to be processed and
      # events that are processing, or may have errored out.
      model.update(last_started_processing_at: Time.now)

      operations = policy_scope Operation.with_conditions.with_actions.with_event_type(model.type)

      operations.each do |operation|
        data_set = operation.data_set_for_event(model)

        # Iterate over all of the operation's conditions, and continue to the
        # next operation if any do not match the data set.
        next unless operation.conditions.all? do |condition|
          condition.matches? data_set
        end

        # If we reached this point the condtions all mactch, perform the
        # actions:
        operation.actions.each {|action| action.perform(data_set) }
      end

      # Update the model (event) with the time it was successfully
      # processed at.
      model.update(successfully_processed_at: Time.now)
    end
  end
end
