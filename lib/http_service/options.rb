# frozen_string_literal: true

module HTTPService
  module Options
    module Defaults
      CLIENT_OPTIONS = {
        request: {
          timeout:       Integer(ENV.fetch('HTTP_TIMEOUT', 10)),
          open_timeout:  Integer(ENV.fetch('HTTP_OPEN_TIMEOUT', 5)),
          read_timeout:  Integer(ENV.fetch('HTTP_READ_TIMEOUT', 5)),
          write_timeout: Integer(ENV.fetch('HTTP_WRITE_TIMEOUT', 5))
        }
      }.freeze.dup
      public_constant :CLIENT_OPTIONS

      LOGGER_OPTIONS = {
        headers:   {
          response: true,
          request:  false
        },
        bodies:    {
          response: true,
          request:  true
        },
        errors:    true,
        log_level: :debug
      }.freeze.dup
      public_constant :LOGGER_OPTIONS

      LOGGER_TAG = 'Faraday'
      public_constant :LOGGER_TAG

      LOGGER_INSTRUMENTATION = 'Faraday'
      public_constant :LOGGER_INSTRUMENTATION

      PERSISTENT_OPTIONS = {
        pool_size:    Integer(ENV.fetch('HTTP_POOL_SIZE', 5)),
        idle_timeout: Integer(ENV.fetch('HTTP_IDLE_TIMEOUT', 20))
      }.freeze.dup
      public_constant :PERSISTENT_OPTIONS

      CACHE_PREFIX = 'Faraday'
      public_constant :CACHE_PREFIX

      CACHE_OPTIONS = {
        ignore_body_case:   false,
        expires_in:         1 * 60 * 60,
        race_condition_ttl: 5 * 60
      }.freeze.dup
      public_constant :CACHE_OPTIONS
    end

    include Defaults

    def self.default_builders(*builders)
      @default_builders ||= builders
    end

    def self.default_cache_service_key(service_key = nil)
      @default_cache_service_key ||= service_key
    end
  end
end
