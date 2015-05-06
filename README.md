# Extort

A simple helper for handling Sequel migrations in Sinatra app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'extort'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extort

## Usage

Extort expects $DB to exists. This way all migrations can be executed onto this connection.

## Tasks

Setup

    rake db:init

Add a migration

    rake db:migration:add[AddSomeAwesomeFeature]

Apply migrations

    rake db:migrate

Rollback migrations

    rake db:rollback[VERSION]

Show migration version

    rake db:version

Show all versions

    rake db:versions



## Contributing

1. Fork it ( https://github.com/amaniak/extort/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
