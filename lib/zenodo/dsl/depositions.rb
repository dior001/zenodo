require 'zenodo/dsl'

module Zenodo
  module DSL::Depositions
    # GET /Deposit/Depositions
    # Get depositions.
    # @return [Array, nil].
    def get_depositions
      Resources::Deposition.parse(request(:get, "deposit/depositions/", nil, nil))
    end

    # GET /Deposit/Deposition/{id}
    # Get a deposition.
    # @param [String, Fixnum] id A deposition's ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Zenodo::Resources::deposition, nil].
    def get_deposition(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Deposition.parse(request(:get, "deposit/depositions/#{id}"))
    end

    # POST /Deposit/Depositions
    # Creates a deposition.
    # @param [Hash] deposition The deposition to create.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Zenodo::Resources::deposition, nil].
    def create_deposition(options={})
      deposition = options[:deposition] || raise(ArgumentError, "Must supply :deposition")
      raise ArgumentError, "Deposition cannot be blank" if deposition.blank?
      Resources::Deposition.parse(request(:post, "deposit/depositions/", deposition))
    end

    # PUT /Deposit/Depositions
    # Updates a deposition.
    # @param [String, Fixnum] id A deposition's ID.
    # @param [Hash] deposition The deposition to update.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Zenodo::Resources::deposition, nil].
    def update_deposition(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      deposition = options[:deposition] || raise(ArgumentError, "Must supply :deposition")
      Resources::Deposition.parse(request(:put, "deposit/depositions/#{id}", deposition))
    end

    # DELETE /Deposit/Depositions/{id}
    # Deletes a deposition.
    # @param [String, Fixnum] id A deposition's ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Faraday::Response].
    def delete_deposition(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      request(:delete, "deposit/depositions/#{id}")
    end
  end
end
