module MessagebirdSms
  class Configuration < ActionTexter::Configuration
    def initialize
      @endpoint = 'https://rest.messagebird.com'
      @path = '/messages'
    end
  end
end
