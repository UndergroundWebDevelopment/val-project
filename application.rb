require File.expand_path('../environment', __FILE__)

module API
end

require 'backend-app/api/base'
require 'backend-app/representers/base_representer'

Dir["#{File.dirname(__FILE__)}/backend-app/models/concerns/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/backend-app/models/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/backend-app/**/*.rb"].each {|f| require f}

class API::Root < Grape::API
  format :json

  mount API::Status
end

ApplicationServer = Rack::Builder.new {
  if ['production', 'staging'].include? Application.config.env
    use Rack::SslEnforcer
  end

  map "/" do
    run API::Root
  end
}
