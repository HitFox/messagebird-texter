require 'action_texter'
require 'messagebird_sms/configuration'

module MessagebirdSms
  autoload :Messenger, 'messagebird_sms/messenger'
  autoload :Message, 'messagebird_sms/message'
  autoload :MessageDelivery, 'messagebird_sms/message_delivery'
  autoload :Request, 'messagebird_sms/request'

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= MessagebirdSms::Configuration.new
    end

    alias_method :config, :configuration
  end
end
