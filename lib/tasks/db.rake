namespace :db do
  desc "Migrates the database to the target version, or to the lastest version if no target is given"
  task :migrate, [:target, :current] => :environment do |t, args|
    require 'sequel/extensions/migration'
    opts = {}
    opts[:target]  = args[:target].to_i  if args[:target]
    opts[:current] = args[:current].to_i if args[:current]

    Sequel::Migrator.run(database, File.join(File.dirname(__FILE__), '../../db/migrations'), opts)
  end

  desc "Migrates the databse back one step from the current version"
  task :rollback => :environment do
    version = database[:schema_info].first.try(:[], :version)

    Rake::Task["db:migrate"].invoke(version - 1) if version
  end

  desc "Creates the database for the current environment"
  task :create => :environment do
    line = Cocaine::CommandLine.new("createdb", ":database " \
                                                "--host :host " \
                                                "--port :port " \
                                                "--username :username")

    line.run(:database => dbconfig[:database],
             :host     => dbconfig[:host],
             :port     => dbconfig[:port].to_s,
             :username => dbconfig[:user])

    Rake::Task["db:set_public_schema_owner"].invoke(dbconfig[:user])
  end

  desc "Drops the database for the current environment"
  task :drop => :environment do
    line = Cocaine::CommandLine.new("dropdb", ":database " \
                                              "--host :host " \
                                              "--port :port " \
                                              "--username :username")

    line.run(:database => dbconfig[:database],
             :host     => dbconfig[:host],
             :port     => dbconfig[:port].to_s,
             :username => dbconfig[:user])
  end

  desc "Dumps the database schema into 'db/structure.sql'"
  task :dump => :environment do
    line = Cocaine::CommandLine.new("pg_dump", "--schema-only :database " \
                                               "--host :host " \
                                               "--port :port " \
                                               "--role :username " \
                                               "--username :username " \
                                               "--file :file")

    line.run(:database => dbconfig[:database],
             :host     => dbconfig[:host],
             :port     => dbconfig[:port].to_s,
             :username => dbconfig[:user],
             :file     => (File.join(File.dirname(__FILE__), '../../db/structure.sql')).to_s)
  end

  desc "Loads the database schema from 'db/structure.sql'"
  task :load => [:drop, :create] do
    line = Cocaine::CommandLine.new("psql", ":database " \
                                            "--host :host " \
                                            "--port :port " \
                                            "--username :username " \
                                            "--file :file")

    line.run(:database => dbconfig[:database],
             :host     => dbconfig[:host],
             :port     => dbconfig[:port].to_s,
             :username => dbconfig[:user],
             :file     => (File.join(File.dirname(__FILE__), '../../db/structure.sql')).to_s)
  end

  task :set_public_schema_owner, [:owner] do |t, args|
    database.execute_ddl("alter schema public owner to #{args[:owner]}")
  end

  private

  def dbconfig
    database.opts
  end

  def database
    AlexWillemsma::Environment.new.database
  end
end
