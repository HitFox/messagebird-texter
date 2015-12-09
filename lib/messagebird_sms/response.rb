require 'messagebird_sms/response/body'
require 'messagebird_sms/response/error'
module MessagebirdSms
  class Response
    attr_reader :net_http_response, :body, :code

    def initialize(net_http_response)
      @net_http_response = net_http_response
      @body              = @net_http_response.body
      @code              = @net_http_response.code
    end

    def success?
      code.to_i == 201
    end

    def failure?
      !success?
    end

    def body
      MessagebirdSms::Response::Body.new(@body) if success?
    end

    def error
      MessagebirdSms::Response::Error.new(@body) if failure?
    end
  end
end
