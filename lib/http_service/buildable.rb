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
  end
end
