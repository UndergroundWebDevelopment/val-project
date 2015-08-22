require "trailblazer/operation/representer"

class Channel < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    include Responder
    include Policy::Pundit
    policy ChannelPolicy, :create?
    model ::Channel, :create

    builds do |params|
      JSON if params[:format] == "json"
    end

    contract do
      property :name
      property :description

      property :type

      property :oauth_token, readable: false

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

    private

    def setup_model!(params)
      model.user = params[:current_user]
    end
  end

  class Update < Create
    policy ChannelPolicy, :update?
    action :update
  end

  class Destroy < Update
    policy ChannelPolicy, :destroy?
    def process(params)
      model.destroy!
    end
  end
end
