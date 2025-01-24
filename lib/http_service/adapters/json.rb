# frozen_string_literal: true

module HTTPService
  module JSON
    def self.included(base)
      base.include(JSONRequest)
      base.include(JSONResponse)
    end

    module JSONRequest
      include ConfigurableClient

      private

      def configure_client(faraday)
        super
        faraday.request(:json)
      end
    end

    module JSONResponse
      include ConfigurableClient

      private

      def configure_client(faraday)
        super
        faraday.response(:json, parser_options: { symbolize_names: true })
      end
    end
  end
end
