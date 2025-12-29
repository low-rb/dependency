# frozen_string_literal: true

require_relative 'providers'

class Dependency
  def define(provider)
  end

  def providers
    Low::Providers.providers
  end

  # # TODO: Provide traditional "include Dependency[:dependency_name]"
  # def self.[](providers)
  #   providers = [*providers]
  # end
end
