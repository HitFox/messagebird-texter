require 'spec_helper'
require 'messagebird_sms/message'
require 'action_texter/validator/request'

RSpec.describe MessagebirdSms::Message do
  before(:each) do | example|
    MessagebirdSms.configure do |config|
      config.path = '/messages'
      config.endpoint = 'http://messagebird.sms.org'
      config.content_type = 'application/json'
      config.product_token = 'SOME_TOKEN'
    end
  end
  let(:message_body) { 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirood tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At v' }
  
  let(:message) do
    message = described_class.new
    message.from = 'ACME'    
    message.to = '+41 44 111 22 33'      
    message.body = message_body
    message.reference = 'Ref:123'
    message
  end
  
  describe '#request' do
    it { expect(message.request).to be_kind_of(MessagebirdSms::Request) }
  end
  
  describe '#to_json' do
    before { MessagebirdSms.configure { |config| config.product_token = 'SOMETOKEN' } }
    
    context 'when all attributes set' do
      let(:json_body) { JSON.generate({ recipients: '+41 44 111 22 33', originator: 'ACME', body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirood tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At v' }) }
      it { expect(message.to_json).to eq json_body }
    end    
    
    # context 'when reference is missing' do
    #   subject(:resource) do
    #     message.reference = nil
    #     message
    #   end
    #   let(:json_body) { '{ 'recipient': '+41 44 111 22 33', 'originator': 'ACME', 'message': message_body }' }
    #   it { expect(resource.to_json).to eq json_body }
    # end
  end
end
