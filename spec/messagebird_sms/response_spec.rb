require 'spec_helper'
require 'messagebird_sms/response'
require 'messagebird_sms/response/error'

RSpec.fdescribe MessagebirdSms::Response do
  let(:successful_response) do 
    http_response = Net::HTTPOK.new('post', 201, 'created')
    http_response.content_type = 'application/json'
    allow(http_response).to receive(:body).and_return('')
    described_class.new(http_response)
  end
  
  describe '#success?' do
    context 'when response is successful' do
      it { expect(successful_response.success?).to be true }
    end
  end

  describe '#error' do
    context 'when response succeeded' do
      it {expect(successful_response.success?).to be true }
    end
    
    context 'when response is unauthorized' do
      subject(:resource) do
        http_response = Net::HTTPOK.new('post', 401, 'unauthorized')
        http_response.content_type = 'appliaction/json'
        allow(http_response).to receive(:body).and_return('{"errors":[{"code":2,"description":"Request not allowed (incorrect access_key)","parameter":"access_key"}]}')
        described_class.new(http_response)
      end

      it { expect(resource.success?).to be false }
      it { expect(resource.failure?).to be true }
      it { expect(resource.error).to be_a_kind_of( MessagebirdSms::Response::Error )}
    end
  end
end