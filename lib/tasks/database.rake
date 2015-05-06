
namespace :db do

  # Actions

  desc "Print all versions"
  task :versions do
    puts Extort.schema_versions
  end

  desc "Print current schema version"
  task :version do
    puts Extort.schema_version
  end

  desc "Execute database migrations"
  task :migrate do
    begin
      Extort.migrate
      Rake::Task['db:version'].execute
    rescue ArgumentError => e
      puts e
    end
  end

  desc "Rollback database migrations"
  task :rollback, [:step] do |t, args|
    args.with_defaults(step: Extort.schema_version)
    begin
      Extort.rollback args[:step]
      Rake::Task['db:version'].execute
    rescue ArgumentError => e
      puts e
    end
  end

  desc "Init Extort for first time"
  task :init do
    puts Extort.init
  end

  # Migration namespace

  namespace :migration do
    desc "Add new migration file"
    task :add, [:name] do |t, args|
      begin
        Extort.add_migration args[:name]
      rescue ArgumentError => e
        puts e
      end
    end
  end

end