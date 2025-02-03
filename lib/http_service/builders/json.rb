# frozen_string_literal: true

module HTTPService
  module Json
    def self.included(base)
      base.include(Request)
      base.include(Response)
    end

    module Request
      include ConfigurableClient

      private

      def configure_client(faraday)
        super
        faraday.request(:json)
      end
    end

    module Response
      include ConfigurableClient

      private

      def configure_client(faraday)
        super
        faraday.response(:json, parser_options: { symbolize_names: true })
      end
    end
  end
end
