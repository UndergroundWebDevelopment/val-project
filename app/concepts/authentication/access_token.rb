module ValProject
  module Authentication
    class AccessToken < BaseRoute
      # Used by Warden to locate an access token record matching the given
      # string, when attempting to authenticate via Bearer token:
      def self.locate(token_string)
        ValProject::AccessToken.first(token: token_string)
      end

      # Endpoint to handle requests for a bearer token. Following OAuth2
      # spec, params will be sent as form-encoded, so we can access
      # them directly from the params hash:
      post "/token" do
        User::SignIn.(params).to_json
      end
    end
  end
end
