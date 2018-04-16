# Executables

Executables gives you an ability to run your rails app's executables via a web interface.

With the help of simple configuration options you can tell executables to expose your executables. Executables will fetch all the executables as per the configuration options, along with their respective executable methods and arguments they accept thus giving you an ability to execute them.

Read more here to know more about the intentions behind building executables.

## Getting Started

Using executables is easy and it requires minimal configuration, please follow below steps to start using it.

1. Add executables to your Gemfile:

```ruby
  gem 'executables'
```

2. Add a initializer in `config/initializers` to tell executables where your executables are, like as follows:

```ruby
Executables.configure do |c|
  c.root_directory = Rails.root
  c.executable_directories = ['app/workers']
end
```

3. Mount web application on desired url, add following to your `config/routes.rb`:

```ruby
  require 'executables/web'
  mount Executables::Web::App => "/admin/executables"
```

You can also use constraints like as follows to limit access:

```ruby
  require 'executables/web'
  executables_constraint = lambda { |request| request.env['warden'].authenticated?(:admin) }

  constraints executables_constraint do
    mount Executables::Web::App => '/admin/executables'
  end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rohitcy/executables.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
