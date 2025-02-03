# frozen_string_literal: true

require 'active_support/concern'

require 'http_service/version'

require 'http_service/errors'
require 'http_service/options'
require 'http_service/configurable_client'
require 'http_service/requester'

require 'http_service/builders/multipart'
require 'http_service/builders/persistent'
require 'http_service/builders/instrumentation'
require 'http_service/builders/raise_error'

require 'http_service/cached/with_rails'
require 'http_service/cached/with_redis'
require 'http_service/cached/with_memory'
require 'http_service/builders/cached'

require 'http_service/builders/json'
require 'http_service/builders/only'
require 'http_service/builders/id_query'

require 'http_service/buildable'
require 'http_service/client'

module HTTPService
end
