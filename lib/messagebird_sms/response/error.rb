module MessagebirdSms
  class Response
    class Error
      attr_reader :code, :description

      ERROR_CODES = { 
                       2 => 'Request not allowed',
                       9 => 'Missing params',
                      10 => 'Invalid params',
                      20 => 'Not found',
                      25 => 'Not enough balance',
                      98 => 'API not found',
                      99 => 'Internal error' 
                    }
   
      def initialize error
        @errors = JSON.parse(error, {:symbolize_names => true})[:errors]
      end

      def errors
        @errors.map{|e| e.merge(error_message: ERROR_CODES[e[:code]])}
      end

      def count
        @errors.count
      end

    end
  end
end