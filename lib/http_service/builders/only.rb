# frozen_string_literal: true

module HTTPService
  module Only
    module Body
      include Requester

      private

      def after_request
        super.body
      end
    end

    module Headers
      include Requester

      private

      def after_request
        super.headers
      end
    end
  end
end
