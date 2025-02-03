# frozen_string_literal: true

module HTTPService
  module RaiseError
    include ConfigurableClient

    private

    def configure_client(faraday)
      super
      faraday.response(:raise_error)
    end
  end
end
