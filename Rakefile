require 'rubygems'
require 'bundler/setup'
require 'dotenv/tasks'

Dir.glob('lib/tasks/*.rake').each { |r| import r }

task :test => :spec

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir['spec/**/*_spec.rb']
  end
rescue LoadError
  # Rspec may not exist in all environments (e.g. production)
end

task :environment => :dotenv do
  require File.join(File.dirname(__FILE__), 'config/environment.rb')
end
