require 'spec_helper'
require 'messagebird_texter/response'
require 'messagebird_texter/response/body'

RSpec.describe MessagebirdSms::Response::Body do
  subject(:body) do
    described_class.new('{
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
                          }')
  end

  subject(:no_date_body) do
    described_class.new('{
                            "createdDatetime":null,
                            "scheduledDatetime":null
                          }')
  end

  describe '#id' do
    context 'returns a sending id' do
      it { expect(body.id).to eql('b1a429b045665b1cea8dda4b45863728') }
    end
  end

  describe '#href' do
    context 'returns a href' do
      it { expect(body.href).to eql('https://rest.messagebird.com/messages/b1a429b045665b1cea8dda4b45863728') }
    end
  end

  describe '#direction' do
    context 'returns a direction' do
      it { expect(body.direction).to eql('mt') }
    end
  end

  describe '#type' do
    context 'returns a type' do
      it { expect(body.type).to eql('sms') }
    end
  end

  describe '#originator' do
    context 'returns a originator' do
      it { expect(body.originator).to eql('me') }
    end
  end

  describe '#content' do
    context 'returns the message body content' do
      it { expect(body.content).to eql('Some text') }
    end
  end
  describe '#reference' do
    context 'returns the message reference' do
      it { expect(body.reference).to eql('user-id') }
    end
  end

  describe '#validity' do
    context 'returns the validity in seconds or nil' do
      it { expect(body.validity).to eql(3600) }
    end
  end

  describe '#gateway' do
    context 'returns the message gateway' do
      it { expect(body.gateway).to eql(10) }
    end
  end

  describe '#datacoding' do
    context 'returns the datacoding' do
      it { expect(body.datacoding).to eql('plain') }
    end
  end

  describe '#scheduled_datetime' do
    context 'returns the scheduled datetime if present' do
      it { expect(body.scheduled_datetime).to be_a_kind_of(Date) }
    end
    context 'returns the nil if scheduled datetime is not present' do
      it { expect(no_date_body.scheduled_datetime).to be_nil }
    end
  end

  describe '#created_datetima' do
    context 'returns the created datetime if present' do
      it { expect(body.created_datetime).to be_a_kind_of(Date) }
    end
    context 'returns the nil if created datetime is not present' do
      it { expect(no_date_body.created_datetime).to be_nil }
    end
  end

  describe '#recipients' do
    context 'returns the recipients as open struct' do
      it { expect(body.recipients).to be_a_kind_of(OpenStruct) }
    end
  end

  describe '#items' do
    context 'returns an array' do
      it { expect(body.recipients.items).to be_a_kind_of(Array) }
    end
  end

  describe '#item' do
    context 'returns an open struct' do
      it { expect(body.recipients.items.first).to be_a_kind_of(OpenStruct) }
    end

    context 'contains a sent status' do
      it { expect(body.recipients.items.first.status).to eql('sent') }
    end

    context 'contains a sent datetime' do
      it { expect(body.recipients.items.first.status_datetime).to be_a_kind_of(Date) }
    end

    context 'contains a recipient phoner number' do
      it { expect(body.recipients.items.first.recipient).to eql(491_759_332_902) }
    end
  end
end
