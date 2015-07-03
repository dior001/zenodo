module Zenodo
  module Errors
    class ClientError < StandardError
      def initialize(method:, url:, headers:, response:)
        super <<-STR.gsub(/^\s*/, '')
          HTTP #{method} #{url}
          Request Headers: #{headers}
          Response Headers: #{response.headers}\n
          Response Body:\n#{response.body}
        STR
        @response = response
      end
    end
  end
end
