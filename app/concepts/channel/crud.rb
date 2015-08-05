require "trailblazer/operation/representer"

class Channel < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    include Responder
    model ::Channel, :create

    builds do |params|
      JSON if params[:format] == "json"
    end

    contract do
      property :name
      property :description

      property :type

      property :oauth_token

      validates :name, :type, presence: true
    end

    class JSON < self
      include Representer

      representer do
        include Roar::JSON
      end
    end

    def process(params)
      validate(params[:channel]) do |form|
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
