# Ex

An attempt to make Ruby look like Elixir.
Without abiding by any rules.

## FAQ

Q: Why?
A: No reason.

Q: What practical application does this have?
A: None.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ex'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ex

## Usage

```
require "elixir"

defmodule MyModule do
  dẹf hello do
    "world"
  end
end

MyModule.hello
=> "world"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elliotthilaire/ex.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
