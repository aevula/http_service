# frozen_string_literal: true

module HTTPService
  module Buildable
    extend ActiveSupport::Concern

    class_methods do
      def http_service_with(*builders)
        Builders.validated!(*builders).each { include(_1) unless include?(_1) }
      end

      def http_service_defaults
        http_service_with(*Options.default_builders)
      end
    end

    module Builders
      ALL = {
        json:            HTTPService::Json,
        json_request:    HTTPService::Json::Request,
        json_response:   HTTPService::Json::Response,
        multipart:       HTTPService::Multipart,
        persistent:      HTTPService::Persistent,
        cached:          HTTPService::Cached,
        only_body:       HTTPService::Only::Body,
        only_headers:    HTTPService::Only::Headers,
        instrumentation: HTTPService::Instrumentation,
        raise_error:     HTTPService::RaiseError,
        id_query:        HTTPService::IdQuery
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

        builder_keys.map { find(_1) }
      end
    end
  end
end
