# frozen_string_literal: true

require_relative '../../lib/dependency'
require_relative '../fixtures/mock_provider'

RSpec.describe Low::Providers do
  before do
    described_class.clear

    Object.send(:remove_const, 'MockProvider')
    load 'spec/fixtures/mock_provider.rb'
  end

  describe 'Providers#providers' do
    it 'creates an provider' do
      Dependency.provide(:mock_provider) do
        MockProvider.new
      end
      expect(described_class.providers[:mock_provider].count).to eq(1)
    end
  end
end
