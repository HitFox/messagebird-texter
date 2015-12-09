module MessagebirdTexter
  class Messenger < ActionTexter::Messenger
    def message
      MessagebirdTexter::Message.new(from: from, to: to, body: body, reference: reference)
    end
  end
end
