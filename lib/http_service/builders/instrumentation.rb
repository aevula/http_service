# frozen_string_literal: true

module HTTPService
  module Instrumentation
    include ConfigurableClient

    private

    def configure_client(faraday)
      super
      faraday.request(:instrumentation, name: self.class::LOGGER_INSTRUMENTATION)
    end
  end
end
