module MessagebirdSms
  class Configuration < ActionTexter::Configuration
    
    ENDPOINT = 'https://rest.messagebird.com'
    PATH     = '/messages'
    
    attr_accessor  :endpoint, :path

    def endpoint
      @endpoint || self.class::ENDPOINT
    end
    
    def path
      @path || self.class::PATH
    end
  end
end