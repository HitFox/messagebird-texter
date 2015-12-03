require 'spec_helper'
require 'webmock/rspec'

RSpec.describe 'deliver sms' do  
  
  before do
    MessagebirdSms.configure do |config|
      config.product_token = 'SOMETOKEN'
      config.endpoint = 'http://test.host.org'
      config.path = '/example'
    end
    
    class NotificationMessenger < MessagebirdSms::Messenger
      def notification
        content from: 'Sender', to: '+41 44 111 22 33', body: 'lorem ipsum', reference: 'Ref:123'
      end
    end
    
    stub_request(:post, "http://test.host.org/example").
      with(
        body: '{"recipients":"+41 44 111 22 33","originator":"Sender","body":"lorem ipsum"}',
        headers: { 'Content-Type' => 'application/json' }).
      to_return(status: 200, body: "", headers: {})
  end
  
  subject { NotificationMessenger.notification.deliver_now! }

  it { expect(subject.success?).to be true }  
end