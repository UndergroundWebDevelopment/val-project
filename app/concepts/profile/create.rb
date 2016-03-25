module AlexWillemsma
  class Profile
    class Create < Trailblazer::Operation
      include Representer

      contract do
        property :first_name
        property :last_name
        include Reform::Form::Dry::Validations
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
