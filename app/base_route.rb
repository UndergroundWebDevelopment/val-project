module ValProject
  class BaseRoute < Sinatra::Base
    register Sinatra::CrossOrigin

    set :show_exceptions, false

    configure do
      enable :cross_origin
    end

    set :allow_origin, ENV.fetch("UI_URL")
    set :allow_methods, [:get, :post, :put, :patch, :delete, :options]

    # Set content type specifying JSON-API: 
    before do
      content_type "application/vnd.api+json"
    end

    # Handle accept paramters. Ensure that the client accepts JSON-API, and is
    # not sending any media type parameters, which are not supported for
    # JSON-API requests (see: http://jsonapi.org/format/#content-negotiation)
    before do
      json_api_accept_with_args = false
      accept = request.env["HTTP_ACCEPT"].split(',')
      valid_accepts = accept.select do |accept_header|
        content_type, args = accept_header.split(';')
        json_api_accept_with_args = true unless args.nil?
        content_type == "application/vnd.api+json" && args.nil?
      end
      halt 406, "Not Acceptable" if valid_accepts.empty?
      halt 415, "Unsupported Media Type" if json_api_accept_with_args
    end

    # Handle options requests, used for the CORS standard 'preflight' requests:
    options "*" do
      response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
      response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

      200
    end

    error UnauthorizedError do
      errors_object = {
        errors: [{
          status: 401,
          code: "Unauthorized",
          title: "Unauthorized",
          detail: env['sinatra.error'].message,
        }]
      }

      halt 401, errors_object.to_json
    end
    
    private

    attr_accessor :params

    def authenticate
      if env.key? "HTTP_AUTHORIZATION"
        sesh = Session.first id: env["HTTP_AUTHORIZATION"].gsub("Token", "").strip
        if sesh
          params[:session] = sesh
          return true
        end
      end

      false
    end

    def require_authenticated_user!
      raise UnauthorizedError.new "You must log in to access that resource." unless authenticate
    end
  end
end
