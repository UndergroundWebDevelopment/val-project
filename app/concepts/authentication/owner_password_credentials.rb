module ValProject
  module Authentication
    class OwnerPasswordCredentials
      def self.locate(client_id, client_secret = nil)
        # Currently ONLY handles the official UI client, which MUST NOT pass
        # a client secret, since it's an ember app and by definition public:
        if ENV.fetch('UI_CLIENT_ID') == client_id && (client_secret.nil? || client_secret.empty?)
          EmberAppOfficial.new
        end
      end

      class EmberAppOfficial
        attr_accessor :user

        def valid?(options)
          self.user = User.first email: options[:username]
          user && user.password_is?(options[:password])
        end
      end
    end
  end
end
