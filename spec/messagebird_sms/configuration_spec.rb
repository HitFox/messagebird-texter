require 'spec_helper'
require 'messagebird_sms/configuration'

RSpec.describe MessagebirdSms::Configuration do
  
  it 'has a endpoit set in constant' do
    expect(MessagebirdSms::Configuration::ENDPOINT).to eq 'https://rest.messagebird.com'
  end
  
  it 'has a path default' do
    expect(MessagebirdSms::Configuration::PATH).to eq '/messages'
  end
  
  let(:config) { described_class.new }

  describe '#endpoint' do
    context 'when endpoint is set through setter' do
      subject(:resource) do 
        config.endpoint = 'http://local.host'
        config
      end
      it 'returns the setted endpoint' do
        expect(resource.endpoint).to eq 'http://local.host'
      end
    end
    
    context 'when endpoint is not set' do
      it 'returns the default enpoint set in constant' do
        expect(config.endpoint).to eq MessagebirdSms::Configuration::ENDPOINT
      end
    end
  end
  
  describe '#path' do
    context 'when path is set through setter' do
      subject(:resource) do 
        config.path = '/example'
        config
      end
      it 'returns the setted path' do
        expect(resource.path).to eq '/example'
      end
    end
    
    context 'when path is not set' do
      it 'returns the default enpoint set in constant' do
        expect(config.path).to eq MessagebirdSms::Configuration::PATH
      end
    end
  end
  
  
  describe '#product_token' do
    context 'when product_token is set through setter' do
      subject(:resource) do 
        config.product_token = 'SOMETOKEN'
        config
      end
      it 'returns the setted product_token' do
        expect(resource.product_token).to eq 'SOMETOKEN'
      end
    end
    
    context 'when product_token is set through api_key setter' do
      subject(:resource) do 
        config.api_key = 'SOMEKEY'
        config
      end
      it 'returns the setted product_token' do
        expect(resource.product_token).to eq 'SOMEKEY'
      end
    end
  end
end
