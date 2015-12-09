require 'messagebird_sms/response'
require 'messagebird_sms/validator/request'

module MessagebirdSms
  class Request < ActionTexter::Request
    attr_accessor :body

    attr_reader :response

    def initialize(body)
      @body     = body
      @endpoint = MessagebirdSms.config.endpoint
      @path     = MessagebirdSms.config.path
      @api_key  = MessagebirdSms.config.product_token
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
      MessagebirdSms::Validator::Request.new
    end
  end
end
