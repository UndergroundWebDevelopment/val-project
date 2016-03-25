module AlexWillemsma
  class App < Sinatra::Base
    configure do
      set :server, :puma
    end

    get "/" do
      "Hello world!"
    end
  end
end
