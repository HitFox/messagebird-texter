require 'phony'
module MessagebirdTexter
  module Validator
    class Message
      class FromTooLong < ArgumentError; end
      class FromMissing < ArgumentError; end
      class ToMissing < ArgumentError; end
      class BodyMissing < ArgumentError; end
      class BodyTooLong < ArgumentError; end
      class ToUnplausible < ArgumentError; end

      attr_reader :message

      def initialize(message)
        @message = message
        validate
      end

      def validate
        fail FromMissing, 'The value for the from attribute is missing.' unless sender_present?
        fail FromTooLong, 'The value for the sender attribute must contain 1..11 characters.' unless sender_length?
        fail ToMissing, 'The value for the to attribute is missing.' unless receiver_present?
        fail BodyMissing, 'The body of the message is missing.' unless body_present?
        fail BodyTooLong, 'The body of the message has a length greater than 160.' unless body_correct_length?
        fail ToUnplausible, "The given value for the to attribute is not a plausible phone number.\nMaybe the country code is missing." unless receiver_plausible?
      end

      def receiver_plausible?
        receiver_present? && Phony.plausible?(message.to)
      end

      def receiver_present?
        !message.to.nil? && !message.to.empty?
      end

      def sender_present?
        !message.from.nil? && !message.from.empty?
      end

      def sender_length?
        sender_present? && message.from.length <= 11
      end

      def body_present?
        !message.body.nil? && !message.body.empty?
      end

      def body_correct_length?
        body_present? && message.body.length <= 160
      end

      def product_token_present?
        !MessagebirdTexter.config.product_token.nil? && !MessagebirdTexter.config.product_token.empty?
      end
    end
  end
end
