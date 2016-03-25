module AlexWillemsma
  class App < Sinatra::Base
    def environment
      @environment ||= Environment.new
    end

    get "/" do
      "Hello world!"
    end
  end
end
