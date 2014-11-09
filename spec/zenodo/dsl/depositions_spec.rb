require 'spec_helper'

describe Zenodo::DSL::Depositions do
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
  let!(:deposition_id) do
    VCR.use_cassette('create_deposition') do
      deposition = Zenodo.client.create_deposition(deposition: deposition_attributes)
      deposition.id
    end
  end
  let!(:deleted_deposition_id) do
    VCR.use_cassette('create_deposition_for_deletion') do
      deposition = Zenodo.client.create_deposition(deposition: deposition_attributes)
      deposition.id
    end
  end

  # GET /Deposit/Depositions
  describe '#get_depositions' do
    it 'returns an array of depositions' do
      VCR.use_cassette('get_depositions') do
        depositions = Zenodo.client.get_depositions
        expect(depositions).to be_a(Array)
        expect(depositions.first).to be_a(Deposition)
      end
    end
  end
  
  # GET /Deposit/Depositions/{id}
  describe '#get_deposition' do
    it 'returns a deposition' do
      VCR.use_cassette('get_deposition') do
        expect(Zenodo.client.get_deposition(id: deposition_id)).to be_a(Deposition)
      end
    end
  end

  # POST /Deposit/Depositions
  describe '#create_deposition' do
    it 'creates a deposition' do
      VCR.use_cassette('create_deposition') do
        response = Zenodo.client.create_deposition(deposition: {})
        expect(response).to be_a(Deposition)
      end
    end
  end

  # PUT /Deposit/Depositions
  describe '#update_deposition' do
    it 'updates a deposition' do
      VCR.use_cassette('update_deposition') do
        deposition = Zenodo.client.get_deposition(id: deposition_id)
        response = Zenodo.client.update_deposition(deposition: deposition)
        expect(response).to be_a(Deposition)
      end
    end
  end

  # DELETE /Deposit/Depositions/{id}
  describe '#delete_deposition' do
    it 'returns a response with code 204' do
      VCR.use_cassette('delete_deposition') do
        response = Zenodo.client.delete_deposition(id: deleted_deposition_id)
        expect(response.status).to eq(204)
      end
    end
  end
end