source 'https://rubygems.org'

# This line reads the ruby version out of the .ruby-version file, strips off
# any patch level, and then sets it using Bundler's "ruby" directive. This will
# cause bundler to raise an exception if any bundled script is run with a
# different version of Ruby.
ruby_version = IO.readlines(".ruby-version")[0]
version_parts = ruby_version.split('-')
if version_parts.size >= 2 && version_parts[0] == 'ruby'
  # Handles a case where we are prefixing the .ruby-version with ruby-, which
  # is the syntax used by RVM (on our servers)
  ruby version_parts[1].strip
else
  ruby version_parts[0].strip
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# Trailblazer framework on top of rails
# # (https://github.com/apotonick/trailblazer)
gem 'trailblazer'

# Use postgresql as the database for Active Record
gem 'pg'


## Single responsibility libraries:

# Pundit handles authorization (who can see/do what):
gem "pundit"
# Gives us access to rails responders #respond_with, etc.
gem "responders"
# Roar gives us representers (https://github.com/apotonick/roar)
gem "roar-rails"


## Rails Front-End UI compontents:

# Cells comes from the same guy who makes Trailblazer, and provides better ways
# of data mapping to views. See https://github.com/apotonick/cells
gem "cells"
# Haml support for cells, and dependent pre-released haml
gem 'cells-haml'
gem "haml", github: "haml/haml", ref: "7c7c169"

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Include bootstrap files:
gem 'bootstrap-sass', '~> 3.3.5'
# Simple form, form helpers with support for bootstrap styling.
gem 'simple_form'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


## Extra / Backports
gem "active_model-errors_details"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Rspec for tests
  gem 'rspec-rails', '~> 3.0'
  # Capybara for acceptance / integration testing of the UI
  gem 'capybara'

  # Rspec api documentation supports API acceptance tests that double as
  # API documentation generators
  gem 'rspec_api_documentation'
end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

