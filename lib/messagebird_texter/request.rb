require 'messagebird_texter/response'
require 'messagebird_texter/validator/request'

module MessagebirdTexter
  class Request < ActionTexter::Request
    attr_accessor :body

    attr_reader :response

    def initialize(body)
      @body     = body
      @endpoint = MessagebirdTexter.config.endpoint
      @path     = MessagebirdTexter.config.path
      @api_key  = MessagebirdTexter.config.product_token
    end

    def perform
      if valid?
        uri = URI.parse(@endpoint)
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          @response = Response.new(http.post(@path, body, 'Authorization' => "AccessKey #{@api_key}", 'Content-Type' => 'application/json'))
        end
        response
      end
    end

    def valid?
      MessagebirdTexter::Validator::Request.new
    end
  end
end
