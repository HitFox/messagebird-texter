require 'json'
require 'phony'
require 'messagebird_texter/validator/message'

module MessagebirdTexter
  class Message < ActionTexter::Message
    def request
      MessagebirdTexter::Request.new(to_json)
    end

    def to_json
      JSON.generate(recipients: to,
                    originator: from,
                    body: body)
    end

    def valid?
      MessagebirdTexter::Validator::Message.new self
    end
  end
end
