module ValProject
  class Session
    class Create < Trailblazer::Operation
      include Representer

      contract do
        include Reform::Form::Dry::Validations

        property :email, virtual: true
        property :password, virtual: true

        validation :default do
          key(:email, &:filled?)
          key(:password, &:filled?)
        end
      end

      representer do
        include Roar::JSON::JSONAPI
        type :sessions
        property :id, writeable: false
        property :owned_by_user_id, as: :user_id, writeable: false
        property :created_at, writeable: false
        property :last_seen_at, writeable: false

        property :email, readable: false
        property :password, readable: false
      end

      def model!(_)
        Session.new
      end

      def process(params)
        validate(params[:session]) do
          user = User.first email: contract.email
          raise UnauthorizedError.new "Email address not found or wrong password." unless user && user.password_is?(contract.password)
          model.owned_by_user_id = user.id
          model.save
        end
      end
    end
  end
end
