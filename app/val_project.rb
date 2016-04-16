# Require base route, parent class that provides common functionality to all
# sub-apps:
require File.join(File.dirname(__FILE__), "base_route.rb")

# Require all models:
Dir.glob(File.join(File.dirname(__FILE__), 'models/**/*.rb')) {|match| require match }

# Require all concepts files:
Dir.glob(File.join(File.dirname(__FILE__), 'concepts/**/*.rb')) {|match| require match }

# Core app, this is mounted by the server and requires individual concepts
# (which are really their own separate Sinatra Apps)
module ValProject
  UUID_REGEX = /^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i

  class App < BaseRoute
    use Profile::Routes

    get "/" do
      "Hello world!"
    end
  end
end
