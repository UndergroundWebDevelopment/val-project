require 'securerandom'

module ValProject
  class User
    class SignIn < Trailblazer::Operation
      include Representer

      representer do
        include Roar::JSON
        property :token, as: :access_token, writeable: false
      end

      def model!(_)
        AccessToken.new
      end

      def process(params)
        params[:warden].authenticate! :resource_owner_password_credentials
        # The warden 'user' will be an instance of the client that requested
        # the token, it in turn provides a #user method to access the
        # authenticated user:
        model.user_id = params[:warden].user.user.id
        model.token = SecureRandom.hex
        model.save
      end
    end
  end
end
