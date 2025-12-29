# frozen_string_literal: true

require_relative '../../lib/dependency'
require_relative '../mock_provider'

RSpec.describe Dependency do
  before do
    Low::Providers.clear
  end

  describe '.define' do
    it 'defines a provider' do
      Dependency.define(:mock_provider) do
        MockDependency.new
      end

      expect(Low::Providers.providers.count).to eq(1)
    end
  end
end
