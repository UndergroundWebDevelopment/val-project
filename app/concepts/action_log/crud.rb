require "trailblazer/operation/representer"

class ActionLog < ActiveRecord::Base
  class Update < Trailblazer::Operation
    include CRUD
    include Responder
    model ::ActionLog, :update

    builds do |params|
      JSON if params[:format] == "json"
    end

    contract do
      # NOTE: All fields have writeable: false, action_log updates not
      # supported!
      property :action, writeable: false
      property :payload, type: Hash, writeable: false
      property :successfully_processed_at, type: DateTime, writeable: false, as: :processed_at

      validates :action, presence: true
    end

    class JSON < self
      include Representer

      representer do
        include Roar::JSON
      end
    end

    def process(params)
      validate(params[:action_log]) do |form|
        form.save
      end
    end
  end
end
