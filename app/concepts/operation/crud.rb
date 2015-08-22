require "trailblazer/operation/representer"

class Operation < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    include Responder
    include Policy::Pundit
    policy OperationPolicy, :create?
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

    private

    def setup_model!(params)
      model.user = params[:current_user]
    end
  end

  class Update < Create
    policy OperationPolicy, :update?
    action :update
  end

  class Destroy < Update
    policy OperationPolicy, :destroy?

    def process(params)
      model.destroy!
    end
  end
end
