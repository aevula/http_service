# frozen_string_literal: true

RSpec.describe(HTTPService) do
  describe 'version' do
    it do
      expect(HTTPService::VERSION).not_to be_nil
    end
  end
end
