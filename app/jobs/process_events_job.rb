require 'event_log/process'

class ProcessEventsJob < ActiveJob::Base
  queue_as :default

  def perform(args)
    EventLog::Process.run(args)
  end
end
