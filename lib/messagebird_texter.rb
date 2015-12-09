require 'action_texter'
require 'messagebird_texter/configuration'

module MessagebirdSms
  autoload :Messenger, 'messagebird_texter/messenger'
  autoload :Message, 'messagebird_texter/message'
  autoload :MessageDelivery, 'messagebird_texter/message_delivery'
  autoload :Request, 'messagebird_texter/request'

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
