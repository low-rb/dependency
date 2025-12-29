# frozen_string_literal: true

module Low
  class Provider
    attr_reader :name

    def initialize(name:)
      @name = name
    end
  end
end
