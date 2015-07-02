require 'spec_helper'

shared_examples "zenodo/errors/client_error" do
  subject(:client_error){ described_class.new(
    method:method,
    url:url,
    headers:headers,
    response:response
  )}

  let(:method){ "POST" }
  let(:url){ "http://www.example.com" }
  let(:headers){ "request headers here" }
  let(:response){ double("Response", headers: "response headers", body: "response body") }

  it "prints out a helpful error message" do
    expected_error_message = <<-ERROR.gsub(/^\s*/, '')
       HTTP POST http://www.example.com
       Request Headers: request headers here
       Response Headers: response headers
       Response Body:
       response body
    ERROR

    expect{
      raise client_error
    }.to raise_error(Zenodo::Errors::ClientError, expected_error_message)
  end
end

describe Zenodo::Errors::ClientError  do
  include_examples "zenodo/errors/client_error"
end

describe Zenodo::Errors::ResourceNotFoundError  do
  include_examples "zenodo/errors/client_error"
end
