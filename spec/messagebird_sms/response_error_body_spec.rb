require 'spec_helper'
require 'messagebird_texter/response'
require 'messagebird_texter/response/error'

RSpec.describe MessagebirdSms::Response::Error do
  subject(:object) do
    described_class.new('{"errors":
                            [
                              { "code":2,
                                "description":"Request not allowed (incorrect access_key)",
                                "parameter":"access_key"
                               }
                            ]
                          }')
  end

  describe '#count' do
    context 'returns the total number of errors' do
      it { expect(object.count).to be(1) }
    end
  end

  describe '#errors' do
    context 'is an array of error hashes' do
      it { expect(object.errors).to be_a_kind_of(Array) }
    end

    context 'one error is a hash' do
      it { expect(object.errors.first).to be_a_kind_of(Hash) }
    end

    context 'a single error has an error code, an error message, a description and the name of the faulty/missing parameter' do
      it { expect(object.errors.first[:code]).to eql(2) }
      it { expect(object.errors.first[:description]).to eql('Request not allowed (incorrect access_key)') }
      it { expect(object.errors.first[:parameter]).to eql('access_key') }
      it { expect(object.errors.first[:error_message]).to eql('Request not allowed') }
    end
  end
end
