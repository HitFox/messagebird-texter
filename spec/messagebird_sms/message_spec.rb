require 'spec_helper'
require 'messagebird_sms/message'

RSpec.describe MessagebirdSms::Message do
  
  let(:message_body) { 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirood tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At v' }
  
  let(:message) do
    message = described_class.new
    message.from = 'ACME'    
    message.to = '+41 44 111 22 33'      
    message.body = message_body
    message.reference = 'Ref:123'
    message
  end

  describe '#dcs_numeric?' do
    context 'when dcs is provided as number' do
      it { expect(message.dcs_numeric?).to be true }
    end
    
    context 'when dcs is provided not as number' do
      subject(:resource) do
        message.dcs = 'Fuubar'        
        message
      end
      it { expect(resource.dcs_numeric?).to be false }
    end
  end
  
  describe '#receiver_plausible?' do
    context 'when a valid phone number is provided' do
      it { expect(message.receiver_plausible?).to be true }
    end
    
    context 'when a invalid phone number is provided' do
      subject(:resource) do
        message.to = 'Fuubar'        
        message
      end
      it { expect(resource.receiver_plausible?).to be false }
    end
  end
  
  describe '#receiver_present?' do
    context 'when a valid phone number is provided' do
      it { expect(message.receiver_present?).to be true }
    end
    
    context 'when no phone number is provided' do
      subject(:resource) do
        message.to = nil        
        message
      end
      it { expect(resource.receiver_present?).to be false }
    end
  end
  
  describe '#sender_present?' do
    context 'when a valid from is provided' do
      it { expect(message.sender_present?).to be true }
    end
    
    context 'when no from is provided' do
      subject(:resource) do
        message.from = nil        
        message
      end
      it { expect(resource.sender_present?).to be false }
    end
  end
  
  describe '#body_present?' do
    context 'when a valid body is provided' do
      it { expect(message.body_present?).to be true }
    end
    
    context 'when no body is provided' do
      subject(:resource) do
        message.body = nil        
        message
      end
      it { expect(resource.body_present?).to be false }
    end
  end
  
  describe '#deliver' do
    context 'when product token is missing in configuration' do
      before { 
        #binding.pry
        MessagebirdSms.configure { |config| config.product_token = nil } }
      it { expect { message.deliver }.to raise_error MessagebirdSms::Configuration::ProductTokenMissing }
    end
    
    context 'when all needed attributes set' do
      before do 
        ActionTexter.configure { |config| config.product_token = 'SOMETOKEN' }
        request = instance_double(ActionTexter::Request)
        allow(request).to receive(:perform).and_return(true)
        allow(message).to receive(:request).and_return(request)
      end
      it { expect(message.deliver).to be true }
    end
  end
  
  describe '#deliver!' do
    # context 'when product token is missing in configuration' do
    #   before { MessagebirdSms.configure { |config| config.product_token = nil } }
    #   it { expect { message.deliver! }.to raise_error MessagebirdSms::Configuration::ProductTokenMissing }
    # end
    
    context 'when product token is given' do
      before { ActionTexter.configure { |config| config.product_token = 'SOMETOKEN' } }
      context 'when receiver is missing' do
        subject(:resource) do
          message.to = nil
          message
        end
        it { expect { resource.deliver! }.to raise_error MessagebirdSms::Message::ToMissing }
      end
    
      context 'when sender is missing' do
        subject(:resource) do
          message.from = nil
          message
        end
        it { expect { resource.deliver! }.to raise_error MessagebirdSms::Message::FromMissing }
      end
    
      context 'when body is missing' do
        subject(:resource) do
          message.body = nil
          message
        end
        it { expect { resource.deliver! }.to raise_error MessagebirdSms::Message::BodyMissing }
      end
    
      context 'when body is to long' do
        subject(:resource) do
          message.body = [message.body, message.body].join # 2 x 160 signs
          message
        end
        it { expect { resource.deliver! }.to raise_error MessagebirdSms::Message::BodyTooLong }
      end
    
      context 'when to is not plausibe' do
        subject(:resource) do
          message.to = 'fuubar'
          message
        end
        it { expect { resource.deliver! }.to raise_error MessagebirdSms::Message::ToUnplausible }
      end
    
      context 'when dcs is not a number' do
        subject(:resource) do
          message.dcs = 'fuubar'
          message
        end
        it { expect { resource.deliver! }.to raise_error MessagebirdSms::Message::DCSNotNumeric }
      end
    end
    
    context 'when all needed attributes set' do
      before do 
        MessagebirdSms.configure { |config| config.product_token = 'SOMETOKEN' }
        request = instance_double(ActionTexter::Request)
        allow(request).to receive(:perform).and_return(true)
        allow(message).to receive(:request).and_return(request)
      end
      it { expect(message.deliver).to be true }
    end
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
