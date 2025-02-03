# frozen_string_literal: true

module HTTPService
  module Cached
    module WithRedis
      def self.included(base)
        raise(NotImplementedError)

        # return super if defined?(Redis)
        # raise(ArgumentError, 'Redis not defined')
      end

      def cached(cache_key, options = {}, &); end
    end
  end
end
