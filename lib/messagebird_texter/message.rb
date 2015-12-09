require 'json'
require 'phony'

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
  end
end
