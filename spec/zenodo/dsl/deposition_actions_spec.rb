require 'spec_helper'

describe Zenodo::DSL::DepositionActions do
  let(:deposition_attributes) do
    {
      'metadata' => {
        'title' => 'My first upload',
        'upload_type' => 'poster',
        'description' => 'This is my first upload',
        'creators' =>[{'name' => 'Doe, Jane','affiliation' => 'ZENODO'}]
      }
    }
  end
  let!(:deposition_id) do
    VCR.use_cassette('create_deposition_for_publishing') do
      deposition = Zenodo.client.create_deposition(deposition: deposition_attributes)
      deposition['id']
    end
  end

  # Publish POST deposit/depositions/:id/actions/publish
  describe '#publish_deposition' do
    it 'publishes a deposition' do
      VCR.use_cassette('publish_deposition') do
        response = Zenodo.client.publish_deposition(id: deposition_id)
        expect(response).to be_a(Deposition)
      end
    end
  end

  # Edit POST deposit/depositions/:id/actions/edit

  # Discard POST deposit/depositions/:id/actions/discard
end