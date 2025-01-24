# frozen_string_literal: true

require 'faraday'

module HTTPService
  module ConfigurableClient
    extend ActiveSupport::Concern

    include Options

    def client
      @client ||= Faraday.new(client_options) { |faraday| configure_client(faraday) }
    end

    private

    def client_options
      self.class::CLIENT_OPTIONS
    end

    def configure_client(faraday)
      faraday.response(:logger, nil, self.class::LOGGER_OPTIONS.dup)
    end
  end
end
