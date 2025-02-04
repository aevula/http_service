# frozen_string_literal: true

module HTTPService
  module Builders
    ALL = {
      json:            HTTPService::Json,
      json_request:    HTTPService::Json::Request,
      json_response:   HTTPService::Json::Response,
      multipart:       HTTPService::Multipart,
      persistent:      HTTPService::Persistent,
      instrumentation: HTTPService::Instrumentation,
      raise_error:     HTTPService::RaiseError,
      cached:          HTTPService::Cached,
      id_query:        HTTPService::IdQuery,
      only_body:       HTTPService::Only::Body,
      only_headers:    HTTPService::Only::Headers
    }.freeze
    public_constant :ALL

    def self.find(builder_key)
      builder = ALL[builder_key.to_s.to_sym]
      return builder if builder

      raise(ArgumentError, "Unknown builder #{builder}")
    end

    def self.validated!(*builder_keys)
      builder_keys.map { _1.to_s.to_sym }
                  .uniq!

      unknown = builder_keys - ALL.keys
      raise(ArgumentError, "Unknown builders: #{unknown}") if unknown.any?

      if (builder_keys & %i[only_body only_headers]).count == 2
        raise(ArgumentError, "Can't use only_body and only_headers simultaneously")
      end

      (ALL.keys & builder_keys).map { find(_1) }
    end
  end
end
