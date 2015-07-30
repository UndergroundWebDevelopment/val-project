class Channel < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    model ::Channel, :create

    contract do
      property :name
      property :description

      validates :name, presence: true
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
      @model.destroy!
    end
  end
end
