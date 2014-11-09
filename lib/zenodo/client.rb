require 'faraday'
require 'json'
require 'openssl'
require 'active_support/all'
require 'zenodo/dsl'
require 'zenodo/errors'

module Zenodo
  class Client
    include DSL
    include Errors

    URL = 'https://zenodo.org/api/'
    REQUESTS = [:get, :post, :put, :delete]
    HEADERS = {'Accept' => 'application/json', 'Content-Type' => 'application/json'}

    # @param [String] api_key
    def initialize(api_key = Zenodo.api_key)
      @api_key = api_key

      # Setup HTTP request connection to Zenodo.
      @connection ||= Faraday.new do |builder|
        builder.basic_auth @api_key, ''
        builder.request :url_encoded
        builder.response :logger if Zenodo.logger
        builder.adapter Faraday.default_adapter
      end
    end

    # @param [:get, :post, :put, :delete] method.
    # @param [String] path.
    # @param [Hash] query (optional).
    # @param [Hash] headers request headers (optional).
    # @raise [ArgumentError] If the response is blank.
    # @raise [ResourceNotFoundError] If the response code is 404.
    # @raise [ClientError] If the response code is not in the success range.
    # @return [Faraday::Response] server response.
    def request(method, path, query = {}, headers = HEADERS)
      raise ArgumentError, "Unsupported method #{method.inspect}. Only :get, :post, :put, :delete are allowed" unless REQUESTS.include?(method)

      payload = !query.empty? ? JSON.generate(query) : ''
      response = @connection.run_request(method, "#{URL}#{path}", payload, headers)

      case response.status.to_i
        when 200..299
          return response
        when 404
          raise ResourceNotFoundError.new(response: response)
        else
          raise ClientError.new(response: response)
      end
    end
  end
end