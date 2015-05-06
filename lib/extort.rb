require 'fileutils'
require 'sequel'

require "extort/version"

# Add migration extension to Sequel
Sequel.extension :migration


# Extort
module Extort

  class << self

    # Includes

    include Rake::DSL if defined? Rake::DSL

    # Constants

    NO_VERSION_FOUND  = "no version found"
    DB_MIGRATIONS_DIR = "db"

    # Get current working directiry
    # @return [String] current directory

    def pwd
      Dir.pwd
    end

    # Check for schema table
    # @return [Boolean]

    def schema_table?
      $DB.tables.include?(:schema_migrations)
    end

    # Get schema version
    # @return [String] version of schema

    def schema_version
      if schema_table?
        version_from_field \
          $DB[:schema_migrations].order(:filename).last
      else
        NO_VERSION_FOUND
      end
    end

    # Print all versions
    # @return [Array] with versions

    def schema_versions
      $DB[:schema_migrations].map do |record|
        version_from_field(record)
      end
    end

    # Version from database column
    # @param  record [Hash] raw database record
    # @return [String] timestamp

    def version_from_field record
      unless record.nil?
        record[:filename].split("_").first
      end
    end

    # Execute pending migrations
    # @return [Void]

    def migrate
      Sequel::Migrator.run $DB, File.join(pwd, DB_MIGRATIONS_DIR)
    end

    # Rollback migration
    # @return [Void]

    def rollback step
      argument_error(step)
      Sequel::Migrator.run $DB, File.join(pwd, DB_MIGRATIONS_DIR), \
        target: step.to_i
    end

    # Add a new migration file
    # @return [String] file path

    def add_migration name
      argument_error(name)
      FileUtils.touch filename(name)
    end


    # Setup new extort env.
    # @return [Boolean]

    def init
      if Dir.exists?(DB_MIGRATIONS_DIR)
        "#{DB_MIGRATIONS_DIR} directory already exists"
      else
        FileUtils.mkdir_p(DB_MIGRATIONS_DIR)
        "#{DB_MIGRATIONS_DIR} directory created"
      end
    end


    # Return directory of gem.
    # @return [String] path to gem directory

    def spec_directory
      @spec_directory ||= \

        Gem::Specification
          .find_by_name(self.to_s.downcase)
          .gem_dir
    end


    # Install rake tasks (from other gems or apps)

    def install_tasks

      # import tasks
      import "#{spec_directory}/lib/tasks/database.rake"
    end

    private

    # Filename based on timestap an name given
    #
    # @param name [String] name of file
    # @return [String] Path to migration file

    def filename name
      timestamp = Time.now.to_i.to_s << "_"
      File.join(DB_MIGRATIONS_DIR, timestamp + name.downcase + '.rb')
    end


    # Raise argument error
    #
    # @param key [Symbol] argument missing

    def argument_error argument
      raise ArgumentError.new "Missing #{argument}" if argument.nil?
    end

  end

end
