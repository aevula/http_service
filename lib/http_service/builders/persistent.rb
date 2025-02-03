# frozen_string_literal: true

require 'faraday/net_http_persistent'

module HTTPService
  module Persistent
    extend ActiveSupport::Concern

    include ConfigurableClient
    include Options

    class_methods do
      def client(client = nil)
        @client ||= client
      end
    end

    def client
      self.class.client || self.class.client(super)
    end

    private

    def configure_client(faraday)
      super
      faraday.adapter(:net_http_persistent, pool_size: PERSISTENT_OPTIONS[:pool_size]) do |adapter|
        adapter.idle_timeout = PERSISTENT_OPTIONS[:idle_timeout]
      end
    end
  end
end
