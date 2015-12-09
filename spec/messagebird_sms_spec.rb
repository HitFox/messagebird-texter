require 'spec_helper'

RSpec.describe MessagebirdTexter do
  it 'has a version number' do
    expect(MessagebirdTexter::VERSION).not_to be nil
    expect(MessagebirdTexter.version).not_to be nil
  end

  before do
    MessagebirdTexter.configure do |config|
      config.from = '+41 44 111 22 33'
      config.to = '+41 44 111 22 33'
      config.product_token = 'SOMETOKEN'
      config.endpoint = 'https://rest.messagebird.com'
      config.path = '/example'
    end
  end

  describe '.configuration' do
    it 'delegates all defaults to the current configuration' do
      expect(MessagebirdTexter.config.from).to eq '+41 44 111 22 33'
      expect(MessagebirdTexter.config.to).to eq '+41 44 111 22 33'
      expect(MessagebirdTexter.config.product_token).to eq 'SOMETOKEN'
      expect(MessagebirdTexter.config.endpoint).to eq 'https://rest.messagebird.com'
      expect(MessagebirdTexter.config.path).to eq '/example'
    end
  end
end
