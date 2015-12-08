require 'spec_helper'

RSpec.describe MessagebirdSms do
  
  it 'has a version number' do
    expect(MessagebirdSms::VERSION).not_to be nil
    expect(MessagebirdSms.version).not_to be nil
  end
  
  before do
    MessagebirdSms.configure do |config|
      config.from = '+41 44 111 22 33'
      config.to = '+41 44 111 22 33'
      config.product_token = 'SOMETOKEN'
      config.endpoint = 'https://rest.messagebird.com'
      config.path = '/example'
    end
  end
  
  describe '.configuration' do
    it 'delegates all defaults to the current configuration' do
      expect(MessagebirdSms.config.from).to eq '+41 44 111 22 33'
      expect(MessagebirdSms.config.to).to eq '+41 44 111 22 33'
      expect(MessagebirdSms.config.product_token).to eq 'SOMETOKEN'
      expect(MessagebirdSms.config.endpoint).to eq 'https://rest.messagebird.com'
      expect(MessagebirdSms.config.path).to eq '/example'
    end
  end
end
