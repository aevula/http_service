# frozen_string_literal: true

module HTTPService
  module Client
    extend ActiveSupport::Concern

    include Requester
    include Buildable

    HTTP_METHOD = nil
    public_constant :HTTP_METHOD

    URL = nil
    public_constant :URL

    PATH = nil
    public_constant :PATH

    DEFAULT_BODY = {}.freeze
    public_constant :DEFAULT_BODY

    DEFAULT_HEADERS = {}.freeze
    public_constant :DEFAULT_HEADERS

    CONSTANT_BODY = {}.freeze
    public_constant :CONSTANT_BODY

    CONSTANT_HEADERS = {}.freeze
    public_constant :CONSTANT_HEADERS

    class_methods do
      def call(http_method = nil, url: nil, path: nil, body: {}, headers: {})
        new(http_method, url:, path:, body:, headers:).call
      end
    end

    def initialize(http_method = nil, url: nil, path: nil, body: {}, headers: {})
      http_method ||= self.class::HTTP_METHOD
      url ||= self.class::URL
      path ||= self.class::PATH
      super
    end

    private

    def before_request
      super
      @body = default_body.merge(body).merge(constant_body)
      @headers = default_headers.merge(headers).merge(constant_headers)
    end

    def default_body
      self.class::DEFAULT_BODY
    end

    def default_headers
      self.class::DEFAULT_HEADERS
    end

    def constant_body
      self.class::CONSTANT_BODY
    end

    def constant_headers
      self.class::CONSTANT_HEADERS
    end
  end
end
