module Zenodo
  module Errors
    class ClientError < StandardError
      def initialize(options={})
        method = options[:method] || raise(ArgumentError, "Must supply :method")
        url = options[:url] || raise(ArgumentError, "Must supply :url")
        response = options[:response] || raise(ArgumentError, "Must supply :response")
        headers = options[:headers]

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
