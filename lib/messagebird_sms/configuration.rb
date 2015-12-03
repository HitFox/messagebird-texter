module MessagebirdSms
  class Configuration
    class ProductTokenMissing < ArgumentError; end
    class EndpointMissing < ArgumentError; end
    class PathMissing < ArgumentError; end
    
    ENDPOINT = 'https://rest.messagebird.com'
    PATH     = '/messages'
    DCS      = 0
    
    attr_accessor :from, :to, :product_token, :endpoint, :path, :dcs
    
    alias :'api_key=' :'product_token='  
    
    def endpoint
      @endpoint || ENDPOINT
    end
    
    def path
      @path || PATH
    end
    
    def dcs
      @dcs || DCS
    end
    
    def defaults
      @defaults ||= { from: from, to: to, dcs: dcs }
    end
  end
end