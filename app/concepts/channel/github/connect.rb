class Channel < ActiveRecord::Base
  module Github
    class Connect < Trailblazer::Operation
      def process(params)
        # One-off instance of github library to exchange the code for the
        # token:
        token = ::Github.new.get_token(params[:code])

        # New connection, using our token to access data:
        github = ::Github.new(oauth_token: token.token)
        # Load user from github:
        user = github.users.get

        # Create a channel, storing oauth_token and user data:
        op = Channel::Create[channel: {
          name: user.name,
          type: "github", # TODO: Standardize channel types somehow
          description: user.bio,
          oauth_token: token.token,
        }]
        @model = op.model
      end

      def model
        @model
      end
    end
  end
end
