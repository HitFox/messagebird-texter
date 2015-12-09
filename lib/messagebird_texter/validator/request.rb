module MessagebirdTexter
  module Validator
    class Request
      class ProductTokenMissing < ArgumentError; end
      class EndpointMissing < ArgumentError; end
      class PathMissing < ArgumentError; end
      class ContentTypeMissing < ArgumentError; end

      def initialize
        @endpoint     = MessagebirdTexter.config.endpoint
        @path         = MessagebirdTexter.config.path
        @content_type = MessagebirdTexter.config.content_type
        @api_key      = MessagebirdTexter.config.product_token
        validate
      end

      def validate
        fail EndpointMissing, "Please provide an valid api endpoint.\nIf you leave this config blank, the default will be set to https://rest.sms-service.org  ." if @endpoint.nil? || @endpoint.empty?
        fail ContentTypeMissing, 'Please provide a valid content_type! Defaults to application/json' if @content_type.nil? || @content_type.empty?
        fail PathMissing, "Please provide an valid api path.\nIf you leave this config blank, the default will be set to /message." if @path.nil? || @path.empty?
        fail ProductTokenMissing, "Please provide an valid product key.\nAfter signup at https://www.messagebird.com/, you will find one in your settings." if @api_key.nil?
      end
    end
  end
end
