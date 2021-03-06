module ValProject
  class Profile
    class Routes < JsonAPIBaseRoute
      get "/profiles/:id" do
        Update.present(params).to_json
      end

      post "/profiles" do
        warden.authenticate!
        params[:profile] = request.body.read
        Create.(params).to_json
      end

      put "/profiles/:id" do
        warden.authenticate!
        params[:profile] = request.body.read
        Update.(params).to_json
      end
    end
  end
end
