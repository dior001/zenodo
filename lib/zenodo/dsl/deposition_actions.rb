require 'zenodo/dsl'

module Zenodo
  module DSL::DepositionActions
    # Publish POST deposit/depositions/:id/actions/publish
    # Publishes a deposition.
    # @param [String, Fixnum] id A deposition's ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Zenodo::Resources::deposition, nil].
    def publish_deposition(id:)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Deposition.parse(request(:post, "deposit/depositions/#{id}/actions/publish", nil, nil))
    end

    # Edit POST deposit/depositions/:id/actions/edit
    # Unlock already submitted deposition for editing.
    # @param [String, Fixnum] id A deposition's ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Zenodo::Resources::deposition, nil].
    def edit_deposition(id:)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Deposition.parse(request(:post, "deposit/depositions/#{id}/actions/edit", nil, nil))
    end

    # Discard POST deposit/depositions/:id/actions/discard
    # Discard changes in the current editing session.
    # @param [String, Fixnum] id A deposition's ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Zenodo::Resources::deposition, nil].
    def discard_deposition(id:)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Deposition.parse(request(:post, "deposit/depositions/#{id}/actions/discard", nil, nil))
    end
  end
end