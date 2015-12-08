module MessagebirdSms
  class Response
    class ErrorBody
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
        @error = JSON.parse(error, {:symbolize_names => true})
      end

      def errors
        @error[:errors].map{|e| e.merge(error_code_message: ERROR_CODES[e[:code]])}
      end

      def any?
        errors.any? || false
      end
    end
  end
end