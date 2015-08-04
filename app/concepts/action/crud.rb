require "trailblazer/operation/representer"

class Action < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    include Responder
    model ::Action, :create

    builds do |params|
      JSON if params[:format] == "json"
    end

    self.contract_class = Action::Form

    class JSON < self
      include Representer

      representer do
        include Roar::JSON
      end
    end

    def process(params)
      validate(params[:action]) do |form|
        form.save
      end
    end
  end

  class Update < Create
    action :update
  end

  class Destroy < Update
    def process(params)
      model.destroy!
    end
  end
end
