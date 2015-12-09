module MessagebirdSms
  module Validator
    class Request
      class ProductTokenMissing < ArgumentError; end
      def validate
        fail ProductTokenMissing, "Please provide an valid product key.\nAfter signup at https://www.messagebird.com/, you will find one in your settings." if @api_key.nil?
      end
    end
  end
end