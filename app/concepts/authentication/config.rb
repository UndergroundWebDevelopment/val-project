module ValProject
  module Authentication 
    module Config
      def self.included(including)
        # Configure warden. Must come after the session store, but before any rack
        # apps (e.g. sinatra modular apps) that need authentication.
        Warden::OAuth2.configure do |config|
          config.resource_owner_password_credentials_model = Authentication::OwnerPasswordCredentials
          config.token_model = Authentication::AccessToken
        end

        including.use Warden::Manager do |manager|
          manager.strategies.add :bearer, Warden::OAuth2::Strategies::Bearer
          manager.strategies.add :resource_owner_password_credentials, Warden::OAuth2::Strategies::ResourceOwnerPasswordCredentials
          manager.strategies.add :issuing_access_token, Warden::OAuth2::Strategies::IssuingAccessToken
          manager.strategies.add :accessing_protected_resource, Warden::OAuth2::Strategies::AccessingProtectedResource

          manager.default_strategies :bearer, :accessing_protected_resource
          manager.failure_app = Warden::OAuth2::FailureApp
        end

        # Mount the AccessToken class as an endpoint, it provides the
        # "/token" endpoint where credentials can be exchanged for
        # a token:
        including.use AccessToken
      end
    end
  end
end
