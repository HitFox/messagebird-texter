module MessagebirdSms
  class Messenger < ActionTexter::Messenger
    
    def message
      @message ||= MessagebirdSms::Message.new(from: from, to: to, body: body, reference: reference)
    end
  end
end
  