# frozen_string_literal: true

require_relative 'models/provider'

module Low
  class Providers
    class << self
      def providers
        @providers ||= {}
        @providers
      end

      def upsert(key:)
        providers[key] = Provider.new(key:) if providers[key].nil?
        providers[key]
      end

      def clear
        @providers = {}
      end

      def provide(key:, provider:)
        provider = providers[key] || upsert(key:)
        provider.add_provider(provider:)
      end
    end
  end
end
