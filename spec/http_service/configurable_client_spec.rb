# frozen_string_literal: true

RSpec.describe(HTTPService::ConfigurableClient) do
  let(:service_class) do
    klass = Class.new
    klass.include(described_class)
    klass
  end

  let(:service) { service_class.new }

  describe 'client' do
    it do
      expect(service.client).to be_instance_of(Faraday::Connection)
    end
  end
end
