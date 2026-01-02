# frozen_string_literal: true

require_relative '../../lib/low_dependency'
require_relative '../fixtures/mock_dependencies'
require_relative '../fixtures/mock_provider'

RSpec.describe 'dependencies' do
  describe 'include LowDependency[:dependency]' do
    let(:subject) { IncludeDependency.new }

    before do
      LowDependency.provide(:provider_one) do
        MockProvider.new
      end
    end

    it 'injects dependency' do
      expect(subject.provider_one).to be_instance_of(MockProvider)
    end

    context 'with a string key dependency' do
      let(:subject) { IncludeStringDependency.new }

      before do
        LowDependency.provide('provider_one') do
          MockProvider.new
        end
      end

      it 'injects dependency' do
        expect(subject.provider_one).to be_instance_of(MockProvider)
      end
    end

    context 'with multiple dependencies' do
      let(:subject) { IncludeDependencies.new }

      before do
        LowDependency.provide(:provider_two) do
          MockProvider.new
        end
      end

      it 'injects multiple dependencies' do
        expect(subject.provider_one).to be_instance_of(MockProvider)
        expect(subject.provider_two).to be_instance_of(MockProvider)
      end
    end
  end

  # describe 'def method(dependency: Dependency)' do
  # end
end
