ENV["RACK_ENV"] ||= "development"

Bundler.require(:default, ENV["RACK_ENV"])

module AlexWillemsma
  class Environment
    def database
      @database ||=
        if ENV.key? "DATABASE_URL"
          Sequel.connect(ENV["DATABASE_URL"])
        else
          db_user = ENV["DATABASE_USER"] || ENV["USER"] 
          db_pw = ENV["DATABASE_PASSWORD"] || nil
          Sequel.connect("postgres://localhost/#{ENV["RACK_ENV"]}", user: db_user, password: db_pw)
        end
    end
  end
end
