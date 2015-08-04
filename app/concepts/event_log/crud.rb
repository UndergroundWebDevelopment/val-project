require "trailblazer/operation/representer"

class EventLog < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    include Responder
    model ::EventLog, :create

    builds do |params|
      JSON if params[:format] == "json"
    end

    contract do
      property :type
      property :payload, type: Hash

      validates :type, presence: true
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
      end
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
