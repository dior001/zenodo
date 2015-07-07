require 'zenodo/version'

module Zenodo
  autoload :Client, 'zenodo/client'
  autoload :DSL, 'zenodo/dsl'
  autoload :Resources, 'zenodo/resources'
  autoload :Errors, 'zenodo/errors'
  autoload :Utils, 'zenodo/utils'

  class << self
    # @return [String]
    attr_accessor :api_key
    attr_accessor :url
    attr_accessor :logger
  end

  self.url = 'https://zenodo.org/api/'

  module_function

  # @return [Zenodo::Client]
  def client
    @client ||= Client.new(Zenodo.api_key, Zenodo.url)
  end
end
