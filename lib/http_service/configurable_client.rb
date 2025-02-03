# frozen_string_literal: true

require 'faraday'

module HTTPService
  module ConfigurableClient
    include Options

    def client
      @client ||= Faraday.new(client_options) { |faraday| configure_client(faraday) }
    end

    private

    def client_options
      self.class::CLIENT_OPTIONS
    end

    def configure_client(faraday)
      faraday.response(:logger, logger, self.class::LOGGER_OPTIONS)
    end

    def logger
      SemanticLogger[self.class::LOGGER_TAG] if defined?(SemanticLogger)
    end
  end
end
