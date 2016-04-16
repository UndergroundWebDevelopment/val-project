module ValProject
  class Profile
    class Create < Trailblazer::Operation
      include Representer

      contract do
        property :first_name
        property :last_name
        property :public_description
        property :date_of_birth
        property :tagline
        include Reform::Form::Dry::Validations
      end

      representer do
        include Roar::JSON::JSONAPI
        type :profiles
        property :id
        property :date_of_birth, if: ->(represented:, **) { represented.public_date_of_birth? }
      end

      def model!(_)
        Profile.new
      end

      def process(params)
        validate(params[:profile]) do
          contract.save
        end
      end
    end
  end
end
