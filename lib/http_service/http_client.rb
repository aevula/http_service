# frozen_string_literal: true

module HTTPService
  module HTTPClient
    extend ActiveSupport::Concern

    include HTTPService::ConfigurableClient

    attr_reader :http_method, :url, :path, :body, :headers, :response

    def initialize(http_method, url:, path: nil, body: {}, headers: {})
      @http_method = http_method.to_s.downcase
      @url = url
      @path = path
      @body = body
      @headers = headers
    end

    included do
      def call
        before_request
        send_request
        after_request
      end

      private

      def send_request
        @response = client.__send__(http_method, path, body, headers)
      end
    end

    def before_request; end

    def after_request
      response
    end

    def client_options
      super.merge(url:)
    end
  end
end
