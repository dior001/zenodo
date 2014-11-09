require 'zenodo/version'

module Zenodo
  autoload :Client, 'zenodo/client'
  autoload :DSL, 'zenodo/dsl'
  autoload :Errors, 'zenodo/errors'

  class << self
    # @return [String]
    attr_accessor :api_key
    attr_accessor :logger
  end

  module_function

  # @return [Zenodo::Client]
  def client
    @client ||= Client.new(Zenodo.api_key)
  end
end
