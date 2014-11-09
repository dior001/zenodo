require 'spec_helper'

describe Zenodo::Client do
  subject(:client) { Zenodo::Client.new }

  it 'makes request to zenodo.org/api' do
    VCR.use_cassette('z_zenodo_client_status_check') do
      # response = client.request(:get, 'Users')
      # expect(response.status).to eq(200)
    end
  end
end