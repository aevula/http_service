# frozen_string_literal: true

module HTTPService
  module Cached
    extend ActiveSupport::Concern

    include Requester

    class_methods do
      def cache_with(service_key)
        include(Services.find(service_key))
      end

      def cache_defaults
        cache_with(Options.default_cache_service_key)
      end
    end

    private

    def send_request
      return super unless use_cache?

      @response = cached(cache_key, self.class::CACHE_OPTIONS) { super }
    end

    def use_cache?
      http_method == :get
    end

    def cache_key
      [self.class::CACHE_PREFIX, path, body_to_cache_key].join('/')
    end

    def body_to_cache_key
      body_chars = body.to_a.join
      body_chars.downcase! if self.class::CACHE_OPTIONS[:ignore_body_case]
      body_chars
    end

    module Services
      ALL = { rails:  WithRails, redis: WithRedis, memory: WithMemory }.freeze
      public_constant :ALL

      def self.find(service_key)
        service = ALL[service_key.to_s.to_sym]
        return service if service

        raise(ArgumentError, "Unknown cache service #{service}")
      end
    end
  end
end
