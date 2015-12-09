module MessagebirdTexter
  class Configuration < ActionTexter::Configuration
    def initialize
      @endpoint = 'https://rest.messagebird.com'
      @path = '/messages'
      @content_type = 'application/json'
    end
  end
end
