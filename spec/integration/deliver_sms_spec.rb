require 'spec_helper'
require 'webmock/rspec'

RSpec.describe 'deliver sms' do
  before(:each) do
    @response = '{
                    "id":"b1a429b045665b1cea8dda4b45863728",
                    "href":"https://rest.messagebird.com/messages/b1a429b045665b1cea8dda4b45863728",
                    "direction":"mt",
                    "type":"sms",
                    "originator":"me",
                    "body":"Some text",
                    "reference":"user-id",
                    "validity":3600,
                    "gateway":10,
                    "typeDetails":{},
                    "datacoding":"plain",
                    "mclass":1,
                    "scheduledDatetime":"2015-12-07T20:20:30+00:00",
                    "createdDatetime":"2015-12-07T16:20:30+00:00",
                    "recipients":
                                  {
                                    "totalCount":1,
                                    "totalSentCount":1,
                                    "totalDeliveredCount":0,
                                    "totalDeliveryFailedCount":0,
                                    "items":
                                    [
                                      { "recipient":491759332902,
                                        "status":"sent",
                                        "statusDatetime":"2015-12-07T16:20:30+00:00"
                                      }
                                    ]
                                  }
                  }'

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

    stub_request(:post, 'http://test.host.org/example')
      .with(
        body: '{"recipients":"+41 44 111 22 33","originator":"Sender","body":"lorem ipsum"}',
        headers: { 'Content-Type' => 'application/json' })
      .to_return(status: 201, body: @response, headers: {})
  end
  after(:each) do
    MessagebirdSms.configure do |config|
      config.product_token = 'SOMETOKEN'
      config.endpoint = 'http://test.host.org'
      config.path = '/example'
    end
  end

  describe 'the message delivery response' do
    before { MessagebirdSms.config.product_token = 'SOMETOKEN' }
    subject { NotificationMessenger.notification.deliver_now! }

    it 'reponds to #success? with true' do
      expect(subject.success?).to be(true)
    end

    it 'reponds to #code with 201' do
      expect(subject.code).to eql('201')
    end

    it 'the recipients total_count is 1' do
      expect(subject.body.recipients.total_count).to be(1)
    end
  end
end
