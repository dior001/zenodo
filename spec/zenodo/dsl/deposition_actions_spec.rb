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
  let!(:file) { File.join(APP_ROOT, 'spec/fixtures/test_file_upload.txt') }
  let!(:deposition_id) do
    VCR.use_cassette('create_deposition_for_publishing') do
      deposition = Zenodo.client.create_deposition(deposition: deposition_attributes)
      deposition['id']
    end
  end
  let!(:deposition_file_id) do
    VCR.use_cassette('create_deposition_file_for_publishing') do
      deposition_file = Zenodo.client.create_deposition_file(
        id: deposition_id, file: file)
      deposition_file['id']
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
  describe '#edit_deposition' do
    it 'allows editing of a deposition' do
      VCR.use_cassette('edit_deposition') do
        response = Zenodo.client.edit_deposition(id: deposition_id)
        expect(response).to be_a(Deposition)
      end
    end
  end

  # Discard POST deposit/depositions/:id/actions/discard
  describe '#discard_deposition' do
    it 'discards proposed edits of a deposition' do
      VCR.use_cassette('discard_deposition') do
        response = Zenodo.client.discard_deposition(id: deposition_id)
        expect(response).to be_a(Deposition)
      end
    end
  end
end