require "trailblazer/operation/representer"

class EventLog < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    include Responder
    include Dispatch
    model ::EventLog, :create

    builds do |params|
      JSON if params[:format] == "json"
    end

    contract do
      property :type
      property :payload, type: Hash
      property :channel_id, type: Integer

      validates :type, :channel_id, presence: true

      require "disposable/twin/persisted"
      feature Disposable::Twin::Persisted
    end

    callback do
      on_create :process_later!
    end

    class JSON < self
      include Representer

      representer do
        include Roar::JSON
      end
    end

    def process(params)
      validate(params[:event_log]) do |form|
        form.save
        dispatch!
      end
    end

    def process_later!(options)
      # ProcessEventsJob takes a hash containing the id of the event to
      # process:
      ProcessEventsJob.perform_later(id: model.id)
    end
  end

  class Update < Create
    action :update

    contract do
      property :type, writeable: false
      property :payload, type: Hash, writeable: false
    end
  end
end
