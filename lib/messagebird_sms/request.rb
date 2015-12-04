require 'messagebird_sms/response'

module MessagebirdSms
  class Request
    attr_accessor :body
    
    attr_reader :response
    
    def initialize(body)
      @body     = body
      @endpoint = MessagebirdSms.config.endpoint
      @path     = MessagebirdSms.config.path
      @api_key  = MessagebirdSms.config.product_token
    end
    
    def perform
      raise MessagebirdSms::Configuration::EndpointMissing.new("Please provide an valid api endpoint.\nIf you leave this config blank, the default will be set to https://rest.messagebird.com.") if @endpoint.nil? || @endpoint.empty?
      raise MessagebirdSms::Configuration::PathMissing.new("Please provide an valid api path.\nIf you leave this config blank, the default will be set to /message.") if @path.nil? || @path.empty?
      raise MessagebirdSms::Configuration::PathMissing.new("Please provide an valid api path.\nIf you leave this config blank, the default will be set to /message.") if @path.nil? || @path.empty?
      raise MessagebirdSms::Configuration::ProductTokenMissing.new("Please provide an valid product key.\nAfter signup at https://www.messagebird.com/, you will find one in your settings.") if @api_key.nil?
      uri = URI.parse(@endpoint)
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        @response = Response.new(http.post(@path, body, initheader = {'Authorization' => "AccessKey #{@api_key}", 'Content-Type' => 'application/json' }))
      end
      response
    end
  end
end