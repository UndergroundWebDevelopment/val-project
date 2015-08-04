require 'action/process'

class ProcessActionJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Action::Process.run(*args)
  end
end
