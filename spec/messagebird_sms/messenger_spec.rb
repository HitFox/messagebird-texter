require 'spec_helper'
require 'messagebird_sms/messenger'

RSpec.describe MessagebirdSms::Messenger do
  
  before do
    class NotificationMessenger < MessagebirdSms::Messenger
      def notification
        content from: 'Sender'
      end
    end
  end
    
  let(:message_body) { 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirood tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At v' }
  
  let(:messenger) do
    messenger = described_class.new
    messenger.from = 'ACME'    
    messenger.to = '+41 44 111 22 33'
    messenger.body = message_body
    messenger
  end
  
  describe '#content' do
    context 'when from attribute is given' do
      let(:from) do
        messenger.content(from: 'SOMECORP.')
        messenger.from
      end
      it { expect(from).to eq 'SOMECORP.' }
    end
    
    context 'when to attribute is given' do
      let(:to) do
        messenger.content(to: 'SOMENUMBER')
        messenger.to
      end
      it { expect(to).to eq 'SOMENUMBER' }
    end
    
    context 'when body attribute is given' do
      let(:body) do
        messenger.content(body: 'SOMETEXT')
        messenger.body
      end
      it { expect(body).to eq 'SOMETEXT' }
    end
    
    context 'when no overriding attributes are given' do
      let(:resource) do
        messenger.content
        messenger
      end
      it { expect(resource.from).to eq 'ACME' }
      it { expect(resource.to).to eq '+41 44 111 22 33' }
      it { expect(resource.body).to eq message_body }
    end
  end
  
  describe '#message' do
    subject(:message) { messenger.message }
    context 'when all attributes given' do
      it { expect(message.from).to eq 'ACME' }
      it { expect(message.to).to eq '+41 44 111 22 33' }
      it { expect(message.body).to eq message_body }
    end
  end
end