module ValProject
  class BaseRoute < Sinatra::Base
    register Sinatra::CrossOrigin

    set :show_exceptions, false

    before do
      params[:warden] = warden
    end

    private

    def warden
      env["warden"]
    end
  end
end
