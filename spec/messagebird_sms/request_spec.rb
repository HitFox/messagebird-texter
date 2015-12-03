require 'spec_helper'
require 'messagebird_sms/request'

RSpec.describe MessagebirdSms::Request do
  let(:message_body) { 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirood tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At v' }
  let(:message) do
    message = MessagebirdSms::Message.new
    message.from = 'ACME'    
    message.to = '+41 44 111 22 33'      
    message.body = message_body
    message.reference = 'Ref:123'
    message
  end
  let(:request_body) { message.to_json }
  let(:request) { described_class.new(request_body) }
  
  describe '#perform' do
    context 'when the API endpoint is missing' do
      let(:resource) do
        request.instance_variable_set('@endpoint', nil)
        request
      end
      it { expect { resource.perform }.to raise_error MessagebirdSms::Configuration::EndpointMissing }
    end
    
    context 'when the API path is missing' do
      let(:resource) do 
        request.instance_variable_set('@path', nil)
        request
      end
      it { expect { resource.perform }.to raise_error MessagebirdSms::Configuration::PathMissing }
    end
    
    context 'when request was successful' do
      it 'return a instance MessagebirdSms::Response' do 
        
        http_response = Net::HTTPOK.new('post', 200, 'found')
        http_response.content_type = 'text/json'
        allow(http_response).to receive(:body).and_return('')
        response = MessagebirdSms::Response.new(http_response)
        
        allow_any_instance_of(described_class).to receive(:perform).and_return(response)
        expect(request.perform.success?).to be true
      end
    end
  end
end