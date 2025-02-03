# frozen_string_literal: true

module HTTPService
  module Cached
    module WithMemory
      extend ActiveSupport::Concern

      class_methods do
        def cached_data
          @cached_data ||= {}
        end
      end

      def cached(cache_key, _options = {}, &)
        return unless block_given?

        self.class.cached_data[cache_key] ||= yield
      end
    end
  end
end
