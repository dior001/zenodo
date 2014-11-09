require 'webmock/rspec'
require 'zenodo'
require 'vcr'
include Zenodo::Resources

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
cnf = YAML::load_file(File.join(APP_ROOT, 'config/gem_secret.yml'))
zenodo_api_key = cnf['zenodo_api_key']

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<ZENODO_API_KEY>') { zenodo_api_key }
end

RSpec.configure do |config|
  config.before do
    Zenodo.api_key = zenodo_api_key
  end
end
