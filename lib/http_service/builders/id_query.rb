# frozen_string_literal: true

module HTTPService
  module IdQuery
    include Requester

    private

    def before_request
      super
      @path = "#{path.delete_suffix('/')}/#{body.delete(:id)}".delete_suffix('/')
    end
  end
end
