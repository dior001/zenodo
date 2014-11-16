require 'spec_helper'

describe Zenodo::DSL::DepositionFiles do
  let(:deposition_attributes) do
    {
      'metadata' => {
        'title' => 'My first upload',
        'upload_type' => 'poster',
        'description' => 'This is my first upload',
        'creators' =>[{'name' => 'Doe, John','affiliation' => 'ZENODO'}]
      }
    }
  end
  let(:deposition_file_attributes) do
    {
      'filename' => 'test_file_upload.txt'
    }
  end
  let!(:file) { File.join(APP_ROOT, 'spec/fixtures/test_file_upload.txt') }
  let!(:deposition_id) do
    VCR.use_cassette('create_deposition_with_files') do
      deposition = Zenodo.client.create_deposition(deposition: deposition_attributes)
      deposition['id']
    end
  end
  let!(:deposition_file_id) do
    VCR.use_cassette('create_deposition_file') do
      deposition_file = Zenodo.client.create_deposition_file(
        id: deposition_id, file: file)
      deposition_file['id']
    end
  end
  # let!(:deleted_deposition_file_id) do
  #   VCR.use_cassette('create_deposition_file_for_deletion') do
  #     deposition_file = Zenodo.client.create_deposition_file(
  #       id: deposition_id, file: file, filename: 'foobar.txt')
  #     deposition_file['id']
  #   end
  # end

  # List GET deposit/depositions/:id/files
  # describe '#get_deposition_files' do
  #   it 'returns a array of files for a deposition' do
  #     VCR.use_cassette('get_deposition_files') do
  #       deposition_files = Zenodo.client.get_deposition_files(id: deposition_id)
  #       expect(deposition_files).to be_a(Array)
  #       expect(deposition_files.first).to be_a(DepositionFile)
  #     end
  #   end
  # end

  # Create (upload) POST deposit/depositions/:id/files
  describe '#create_deposition_file' do
    it 'uploads a file for a deposition' do
      VCR.use_cassette('create_deposition_file') do
        deposition_file = Zenodo.client.create_deposition_file(id: deposition_id, file: file)
        expect(deposition_file).to be_a(DepositionFile)
      end
    end
  end

  # # Sort PUT deposit/depositions/:id/files
  # describe '#sort_deposition_files' do
  #   it 'sorts files for a deposition' do
  #     # VCR.use_cassette('sort_deposition_files') do
  #     #   deposition_files = Zenodo.client.sort_deposition_files(
  #     #     id: deposition_id, deposition_files: deposition_file_attributes)
  #     #   expect(deposition_files).to be_a(Array)
  #     #   expect(deposition_files.first).to be_a(DepositionFile)
  #     # end
  #   end
  # end

  # Retrieve GET deposit/depositions/:id/files/:file_id
  describe '#get_deposition_file' do
    it 'gets a deposition file' do
      VCR.use_cassette('get_deposition_file') do
        deposition_file = Zenodo.client.get_deposition_file(id: deposition_id, file_id: deposition_file_id)
        expect(deposition_file).to be_a(DepositionFile)
      end
    end
  end

  # # Update PUT deposit/depositions/:id/files/:file_id
  # describe '#update_deposition_file' do
  #   it 'updates a deposition file' do
  #     # VCR.use_cassette('update_deposition_file') do
  #     #   deposition_file = Zenodo.client.update_deposition_file(
  #     #     id: deposition_id, deposition_file_id: deposition_file_id,
  #     #     deposition_file: deposition_file_attributes)
  #     #   expect(deposition_file).to be_a(DepositionFile)
  #     # end
  #   end
  # end
  #
  # # Delete DELETE deposit/depositions/:id/files/:file_id
  # describe '#delete_deposition_file' do
  #   it 'returns a response with code 204' do
  #     VCR.use_cassette('delete_deposition_file') do
  #       response = Zenodo.client.delete_deposition_file(id: deposition_id, deposition_file_id: deleted_deposition_file_id)
  #       expect(response.status).to eq(204)
  #     end
  #   end
  # end
end