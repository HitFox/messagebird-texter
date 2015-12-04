require 'json'
require 'phony'
#require 'messagebird_sms/request'

module MessagebirdSms
  class Message < ActionTexter::Message

    def request
      MessagebirdSms::Request.new(to_json)
    end
    
    def to_json
      JSON.generate({
        recipients: to,
        originator: from,
        body: body
      })
    end
  end
end