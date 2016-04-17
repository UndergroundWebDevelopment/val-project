module ValProject
  class User
    class Routes < BaseRoute
      get "/users/:id" do
        Update.present(params).to_json
      end

      post "/users/sign_in" do
        params[:session] = request.body.read
        Session::Create.(params).to_json
      end

      post "/users/sign_out" do
        require_authenticated_user!
        Session::Destroy.(params)
        204 # Return a 204 "no content" status response.
      end
    end
  end
end
