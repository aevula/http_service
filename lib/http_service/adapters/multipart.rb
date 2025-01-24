# frozen_string_literal: true

require 'faraday/multipart'

module HTTPService
  module Multipart
    extend ActiveSupport::Concern

    include ConfigurableClient

    private

    def to_multipart!(data_key, mime_key, name_key = nil, opts_key = nil)
      Faraday::Multipart::FilePart.new(
        StringIO.new(body.delete(data_key)),
        body.delete(mime_key),
        body.delete(name_key),
        body.delete(opts_key))
    end

    def configure_client(faraday)
      super
      faraday.request(:multipart)
    end
  end
end
