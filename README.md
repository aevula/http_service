# HTTPService

Gem designed for cleaner and more intuitive way of handling HTTP requests adhering to the Service-Object pattern.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add http_service
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install http_service
```

## Usage

```rb
class BlogFetcher
  include HTTPService::Persistent
  include HTTPService::JSON

  URL = 'http://example.com'
  PATH = 'blogs'
  CONSTANT_BODY = { auth_token: AuthTokenCreator.call }

  def call(**params)
    super(http_method: :get, body: params)
  end

  private

  def before_request
    body[:date] = DateTime.now
  end

  def after_request
    response.body.map { Blog.new(_1) }
  end

  def configure_client(faraday)
    faraday.response(:raise_error)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
