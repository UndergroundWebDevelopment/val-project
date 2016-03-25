module AlexWillemsma
  class Profile
    class Routes < BaseRoute
      get "/profile/:id" do
        Update.present(params).to_json
      end

      post "/profile" do
        params[:profile] = request.body.read
        Create.(params).to_json
      end

      put "/profile/:id" do
        params[:profile] = request.body.read
        Update.(params).to_json
      end
    end
  end
end
