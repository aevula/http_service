# frozen_string_literal: true

require 'active_support/concern'

require 'http_service/version'

require 'http_service/errors'
require 'http_service/options'
require 'http_service/configurable_client'
require 'http_service/http_client'
require 'http_service/client'

require 'http_service/adapters/persistent'
require 'http_service/adapters/json'

module HTTPService
end
