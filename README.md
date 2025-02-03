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
  include HTTPService::Client

  http_service_with :json, :persistent, :only_body, :cached
  cache_with :rails

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
    response.map { Blog.new(_1) }
  end

  def configure_client(faraday)
    faraday.builder.delete(Faraday::Response.lookup_middleware(:logger))
  end
end
```

By default services use `#call` method:

```rb
def call(http_method = nil, url: nil, path: nil, body: {}, headers: {})
  # ...
end
```

### Service-Constants

There are several constant that can be defined in class to be used when calling service.

| Constant         | Description                                        | Extras |
| ---------------- | -------------------------------------------------- | ------ |
| HTTP_METHOD      | HTTP verb                                          |        |
| URL              | Request URL                                        |        |
| PATH             | Request path                                       |        |
| DEFAULT_BODY     | Default request body (params)                      |        |
| DEFAULT_HEADERS  | Default request headers                            |        |
| CONSTANT_BODY    | Constant (non-overwrittable) request body (params) |        |
| CONSTANT_HEADERS | Constant (non-overwrittable) request headers       |        |

#### NOTE

`DEFAULT_BODY` and `DEFAULT_HEADERS` are still written to body/headers even if passed body argument is not empty. Those are values that body/headers are initialized with and can be overwritten by passed `body`/`params` and `CONSTANT_BODY`/`CONSTANT_HEADERS`.

Will be fixed in future releases.

### Options

There are several faraday and builder options implemented in gem. Every single option can be overriden directly in http-service class. Default values are written in [http_service/options.rb](https://github.com/aevula/http_service/blob/master/lib/http_service/options.rb) file.

| Option constant        | Description                                                           | Class  | Extras |
| ---------------------- | --------------------------------------------------------------------- | ------ | ------ |
| CLIENT_OPTIONS         | Request `Faraday::Connection` options (e.g. `timeout`)                | Hash   |        |
| LOGGER_OPTIONS         | Logger options passed to faraday logger middleware (e.g. `log_level`) | Hash   |        |
| LOGGER_TAG             | Tag to be used by logger                                              | String |        |
| LOGGER_INSTRUMENTATION | Name of used instrumentation                                          | String |        |
| PERSISTENT_OPTIONS     | `net_http_persistent` adapter options                                 | Hash   |        |
| CACHE_PREFIX           | Prefix to be used when generation cache_key                           | String |        |
| CACHE_OPTIONS          | Options to be used by cache-service (e.g. `expires_in`)               | Hash   |        |

### Builders

There are multiple configurable builders to use in your http-services. All builders are defined under `HTTPService` module and can be included via 2 ways:

- include builder module in your http-service
- include `HTTP::Client` (comes with over top-level methods) and use `http_service_with` method passing builder codes

| Builder           | Code              | Description                                             | Extras                             |
| ----------------- | ----------------- | ------------------------------------------------------- | ---------------------------------- |
| `Multipart`       | `multipart`       | Use for file-multipart requests                         |                                    |
| `Persistent`      | `persistent`      | Use persistent client and `net_http_persistent`         |                                    |
| `Instrumentation` | `instrumentation` | Adds instrumentation to requests                        |                                    |
| `RaiseError`      | `raise_error`     | Adds `raise_error` faraday middleware                   |                                    |
| `Cached`          | `cached`          | Adds conditional request caching using cache-service    | See [cache-service table](#cached) |
| `Json`            | `json`            | Includes `Json::Request`, `Json::Response`              |                                    |
| `Json::Request`   | `json_request`    | Adds `json` faraday middleware to requests              |                                    |
| `Json::Response`  | `json_response`   | Adds `json` faraday middleware to responses             |                                    |
| `Only::Body`      | `only_body`       | Use to return only body from `Farday::Response`         |                                    |
| `Only::Headers`   | `only_headers`    | Use to return only body from `Farday::Response`         |                                    |
| `IdQuery`         | `id_query`        | Moves `id` parameter from params to url as query-string |                                    |

Also you can setup default builder list on initialization.

```rb
# config/initializers/http_service.rb

HTTPService::Options.default_builders(:json, :persistent, :only_body, :raise_error)
```

### Cached

When using `Cached` builder pass cache-service via 2 ways:

- include cache-service module in your http-service
- include `HTTP::Client` (comes with over top-level methods) and use `cache_with` method passing builder codes

| Cache-service        | Code     | Description              | Extras          |
| -------------------- | -------- | ------------------------ | --------------- |
| `Cached::WithRails`  | `rails`  | Uses `Rails.cache.fetch` |                 |
| `Cached::WithRedis`  | `redis`  |                          | Not implemented |
| `Cached::WithMemory` | `memory` | Uses memoization         |                 |

Also you can setup default cache-service on initialization.

```rb
# config/initializers/http_service.rb

HTTPService::Options.default_cache_service_key(:rails)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
