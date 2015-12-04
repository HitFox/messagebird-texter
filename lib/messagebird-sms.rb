require 'action-texter'
require 'messagebird_sms/configuration'
require 'pry'

module MessagebirdSms
  autoload :Messenger, 'messagebird_sms/messenger'
  autoload :Message, 'messagebird_sms/message'
  autoload :MessageDelivery, 'messagebird_sms/message_delivery'
  autoload :Request, 'messagebird_sms/request'
  autoload :Webhook, 'messagebird_sms/webhook'
  
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= MessagebirdSms::Configuration.new
    end
    
    alias :config :configuration
  end
end