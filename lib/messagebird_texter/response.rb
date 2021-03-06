require 'messagebird_texter/response/body'
require 'messagebird_texter/response/error'
module MessagebirdTexter
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
      MessagebirdTexter::Response::Body.new(@body) if success?
    end

    def error
      MessagebirdTexter::Response::Error.new(@body) if failure?
    end
  end
end
