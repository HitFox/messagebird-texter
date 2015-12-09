require 'spec_helper'
require 'messagebird_texter/configuration'

RSpec.describe MessagebirdSms::Configuration do
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
