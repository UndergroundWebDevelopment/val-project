require "trailblazer/operation/representer"

class Operation < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    include Responder
    model ::Operation, :create

    builds do |params|
      JSON if params[:format] == "json"
    end

    self.contract_class = Operation::Form

    class JSON < self
      include Representer

      representer do
        include Roar::JSON
      end
    end

    def process(params)
      validate(params[:operation]) do |form|
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
