module ValProject
  class User
    class Routes < BaseRoute
      get "/users/:id" do
        Update.present(params).to_json
      end
    end
  end
end
