# frozen_string_literal: true

require_relative 'expressions/dependency'
require_relative 'providers'

class LowDependency
  class << self
    def provide(key, &block)
      Low::Providers.provide(key:, &block)
    end

    def providers
      Low::Providers.providers
    end

    def stack
      @stack ||= []
      @stack
    end

    # "include LowDependency[:dependency]"
    def [](*dependencies)
      item = []

      [*dependencies].each do |dependency|
        case dependency
        when Hash
          key = dependency.keys.first
          dependency = dependency[key]
        else
          key = dependency
        end

        item << (Low::Dependency.new(var: dependency) | key)
      end

      LowDependency.stack << item

      included_hook
    end

    def included_hook
      Module.new do
        def self.included(klass)
          klass.class_eval do
            @low_dependencies = LowDependency.stack.pop

            class << self
              attr_reader :low_dependencies
            end

            def initialize
              self.class.low_dependencies.each do |dependency|
                provider = LowDependency.providers[dependency.key]
                raise StandardError, "Provider #{dependency.key} not found" if provider.nil?

                var = LowDependency.provider_from_namespace(dependency.var)
                instance_variable_set("@#{var}", provider.result)
              end
            end

            @low_dependencies.each do |dependency|
              var = LowDependency.provider_from_namespace(dependency.var)

              define_method(var) do
                instance_variable_get("@#{var}")
              end
            end
          end
        end
      end
    end

    def provider_from_namespace(namespace)
      return namespace.split('.').last if namespace.is_a?(String)

      namespace
    end
  end
end
