# rubocop:disable Metrics/AbcSize
# rubocop:disable MethodLength
module MessagebirdTexter
  class Response
    class Body
      attr_reader :id,
                  :href,
                  :direction,
                  :type,
                  :originator,
                  :content,
                  :reference,
                  :validity,
                  :gateway,
                  :datacoding,
                  :mclass,
                  :scheduled_datetime,
                  :created_datetime,
                  :recipients

      def initialize(body)
        parsed_body         = JSON.parse(body, symbolize_names: true)
        @id                 = parsed_body[:id]
        @href               = parsed_body[:href]
        @direction          = parsed_body[:direction]
        @type               = parsed_body[:type]
        @originator         = parsed_body[:originator]
        @content            = parsed_body[:body]
        @reference          = parsed_body[:reference]
        @validity           = parsed_body[:validity]
        @gateway            = parsed_body[:gateway]
        @datacoding         = parsed_body[:datacoding]
        @mclass             = parsed_body[:mclass]
        @scheduled_datetime = parsed_body[:scheduledDatetime]
        @created_datetime   = parsed_body[:createdDatetime]
        @recipients         = parsed_body[:recipients]
      end

      def scheduled_datetime
        Date.parse(@scheduled_datetime) unless @scheduled_datetime.nil?
      end

      def created_datetime
        Date.parse(@created_datetime) unless @created_datetime.nil?
      end

      def recipients
        OpenStruct.new(
          total_count: @recipients[:totalCount],
          total_sent_count: @recipients[:totalSentCount],
          total_delivered_count: @recipients[:totalDeliveredCount],
          items: items

        ) unless @recipients.nil?
      end
      
      private
      def items
        @recipients[:items].map do |i|
          OpenStruct.new(item(i))
        end
      end

      def item(item)
        {
          recipient: item[:recipient],
          status: item[:status],
          status_datetime: Date.parse(item[:statusDatetime])
        }
      end
    end
  end
end
