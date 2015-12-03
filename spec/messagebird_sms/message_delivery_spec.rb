require 'spec_helper'
require 'messagebird_sms/message_delivery'

RSpec.describe MessagebirdSms::MessageDelivery do
  
  before do
    class NotificationMessenger < MessagebirdSms::Messenger
      def notification(to)
        content from: 'Sender', 
                to: to, 
                body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirood tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At v'
      end
    end
  end
  
  let(:message_delivery) { described_class.new(NotificationMessenger, :notification, '+41 44 222 22 33') }
  let(:message) { message_delivery.message }

  describe '#message' do    
    it { expect(message_delivery.message).to be_kind_of MessagebirdSms::Message }
  end
  
  describe '#deliver_now' do
    context 'when product token is missing in configuration' do
      before { MessagebirdSms.configure { |config| config.product_token = nil } }
      it { expect { message_delivery.deliver_now }.to raise_error MessagebirdSms::Configuration::ProductTokenMissing }
    end
    
    context 'when all needed congigurations given' do
      before do 
        MessagebirdSms.configure { |config| config.product_token = 'SOMETOKEN' }
        request = instance_double(MessagebirdSms::Request)
        allow(request).to receive(:perform).and_return(true)
        allow(message).to receive(:request).and_return(request)
      end
      it { expect(message_delivery.deliver_now).to be true}
    end
  end
  
  describe '#deliver_now!' do
    context 'when product token is missing in configuration' do
      before { MessagebirdSms.configure { |config| config.product_token = nil } }
      it { expect { message_delivery.deliver_now! }.to raise_error MessagebirdSms::Configuration::ProductTokenMissing }
    end
    
    context 'when receiver is missing' do
      before { MessagebirdSms.configure { |config| config.product_token = 'SOMETOKEN' } }
      let(:resource) { described_class.new(NotificationMessenger, :notification, nil) }
      it { expect { resource.deliver_now! }.to raise_error MessagebirdSms::Message::ToMissing }
    end
    
    context 'when sender is missing' do
      before do 
        MessagebirdSms.configure { |config| config.product_token = 'SOMETOKEN' }
        class NotificationMessenger < MessagebirdSms::Messenger
          def notification(to)
            content from: nil, 
                    to: to, 
                    body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirood tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At v'
          end
        end
      end
      it { expect { message_delivery.deliver_now! }.to raise_error MessagebirdSms::Message::FromMissing }
    end
    
    context 'when body is missing' do
      before do 
        MessagebirdSms.configure { |config| config.product_token = 'SOMETOKEN' }
        class NotificationMessenger < MessagebirdSms::Messenger
          def notification(to)
            content from: 'Sender', 
                    to: to, 
                    body: nil
          end
        end
      end
      it { expect { message_delivery.deliver_now! }.to raise_error MessagebirdSms::Message::BodyMissing }
    end
    
    context 'when all needed congigurations given' do
      before do 
        MessagebirdSms.configure { |config| config.product_token = 'SOMETOKEN' }
        request = instance_double(MessagebirdSms::Request)
        allow(request).to receive(:perform).and_return(true)
        allow(message).to receive(:request).and_return(request)
      end
      it { expect(message_delivery.deliver_now).to be true }
    end
  end
  
  describe '#inspect' do
    let(:inspect_output) do
      prefix = "#<#{described_class}:0x#{message_delivery.__id__.to_s(16)}"
      [prefix, '@messenger=NotificationMessenger @message_method=:notification @args=["+41 44 222 22 33"]', ']>'].join(' ')
    end
    it { expect(message_delivery.inspect).to eq inspect_output }
  end
end