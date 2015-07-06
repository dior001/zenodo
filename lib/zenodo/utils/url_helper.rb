module Zenodo
  module Utils
    class UrlHelper
      # Build a URL with a querystring containing optional params if supplied.
      # @param [UrlHelper] path The name of the resource path as per the URL e.g. contacts.
      # @param [Hash] params A hash of params we're turning into a querystring.
      # @return [UrlHelper] The URL of the resource with required params.
      def self.build_url(options={})
        path = options[:path] || raise(ArgumentError, "Must supply :path")
        params = options[:params] || raise(ArgumentError, "Must supply :params")
        params.delete_if {|k,v| v.blank?}
        params = params.to_query
        query = path
        query << ("?" + params) unless params.blank?
        query
      end
    end
  end
end
