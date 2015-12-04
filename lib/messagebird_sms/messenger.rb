module MessagebirdSms
  class Messenger < ActionTexter::Messenger
    
    def message
      @message ||= MessagebirdSms::Message.new(from: from, to: to, dcs: dcs, body: body, reference: reference)
    end

  end
end
  