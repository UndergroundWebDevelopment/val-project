# A sample Gemfile
source "https://rubygems.org"

# Puma web-server, recommended for Heroku deploys, multi-threaded for
# performance:
gem "puma"
# Puma plugin containing default Heroku configs:
gem "puma-heroku"

# Sinatra is a minimalist Ruby framework. Require "sinatra/base" since we're
# using the modular style:
gem "sinatra", require: "sinatra/base"
# Sinatra extension to support Cross-Origin requests:
gem "sinatra-cross_origin", "~> 0.3.1", require: "sinatra/cross_origin"

# sequel is a database library:
gem "sequel"
# the pg gem provides postgres support for sequel:
gem "pg"

# Trailblazer is a framework on top of Sinatra that provides operations,
# representers, contracts, and a whole lot more. See http://trailblazer.to/
gem "trailblazer"
# Roar provides advanced representer support, for serializing
# data to and from json, xml, and other formats.
gem "roar", github: 'apotonick/roar', branch: '1-1'
# Trailblazer uses representable for its representers, and to support
# json requires multi_json as a dependency:
gem "multi_json"

# Data validation dsl:
gem "dry-validation"

# Rake to run maintenance tasks and one-off jobs, e.g. database migrations:
gem "rake"
# Cocaine assists with running command line arguments, e.g. DB
# manipulations:
gem "cocaine"

# Secure hashing algorithms for passwords
gem "bcrypt"

group :development, :test do
  # Allows us to load environment variables defined in .env into ruby
  # code. This is done automatically by foreman, but dotenv lets us re-use
  # these env variables in rake tasks and other places the development
  # environment is used:
  gem "dotenv"
end

group :development do
  # Install rerun in develpment, to automatically re-load code when changes
  # are made:
  gem "rerun"
end

# These gems are _only_ needed when running a console, and so are grouped
# separately:
group :console do
  gem "dotenv"
  gem "pry"
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-git"
  gem "pry-rails"
  gem "pry-remote"
end
