# frozen_string_literal: true

module HTTPService
  module Cached
    module WithRails
      def self.included(base)
        return super if defined?(Rails)

        raise(ArgumentError, 'Rails not defined')
      end

      def cached(cache_key, options = {}, &)
        return unless block_given?

        Rails.cache.fetch(cache_key, **options, &)
      end
    end
  end
end
