require 'zenodo/dsl'

module Zenodo
  module DSL::DepositionFiles
    # List GET deposit/depositions/:id/files
    # List all deposition files for a given deposition.
    # @param [Hash] options The options to get a deposition with.
    # @option options [String, Fixnum] :id A deposition's ID.
    # @raise [ArgumentError] If the given :id is blank.
    # @return [Array, nil].
    def get_deposition_files(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      Resources::DepositionFile.parse(request(:get, "deposit/depositions/#{id}/files", nil))
    end

    # Create (upload) POST deposit/depositions/:id/files
    # Upload a new file.
    # Note the upload will fail if the filename already exists.
    # @param [Hash] options The options to create a deposition file with.
    # @option options [String, Fixnum] :id A deposition's ID.
    # @option options [String, IO] file_or_io The file or already open IO to upload.
    # @option options [String] filename The name of the file (optional except when an IO).
    # @option options [String] content_type The content type of the file (optional except when an IO).
    # @raise [ArgumentError] If the :id or :file_or_io arguments are blank.
    # @return [Zenodo::Resources::DepositionFile].
    def create_deposition_file(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      file_or_io = options[:file_or_io] || raise(ArgumentError, "Must supply :file_or_io")
      filename = options[:filename]
      content_type = options[:content_type]

      content_type = MIME::Types.type_for(file_or_io).first.content_type if content_type.blank?
      io = Faraday::UploadIO.new(file_or_io, content_type, filename)
      filename = File.basename(file_or_io) if filename.blank?
      Resources::DepositionFile.parse(
        request(:post, "deposit/depositions/#{id}/files", { name: filename, file: io },
          "Content-Type" => "multipart/form-data")
      )
    end

    # Sort PUT deposit/depositions/:id/files
    # Sort the files for a deposition. By default, the first file is shown in the file preview.
    # @param [Hash] options The options to sort a deposition's files with.
    # @option options [String, Fixnum] :id A deposition's ID.
    # @option options [Array] :deposition_files The deposition files to sort.
    # @raise [ArgumentError] If :id or :deposition_files arguments are blank.
    # @return [Array, nil].
    def sort_deposition_files(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      deposition_files = options[:deposition_files] || raise(ArgumentError, "Must supply :deposition_files")
      Resources::DepositionFile.parse(request(:put, "deposit/depositions/#{id}/files", deposition_files))
    end

    # Retrieve GET deposit/depositions/:id/files/:file_id
    # Retrieve a single deposition file.
    # @param [Hash] options The options to get a deposition's file with.
    # @option options [String, Fixnum] :id A deposition's ID.
    # @option options [String] :file_id A deposition file ID.
    # @raise [ArgumentError] If :id or :file_id arguments are blank.
    # @return [Zenodo::Resources::DepositionFile].
    def get_deposition_file(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      file_id = options[:file_id] || raise(ArgumentError, "Must supply :file_id")
      Resources::DepositionFile.parse(request(:get, "deposit/depositions/#{id}/files/#{file_id}", nil))
    end

    # Update PUT deposit/depositions/:id/files/:file_id
    # Update a deposition file resource. Currently the only use is renaming an already uploaded file.
    # If you one to replace the actual file, please delete the file and upload a new file.
    # @param [Hash] options The options to update a deposition's file with.
    # @options option [String, Fixnum] :id A deposition's ID.
    # @options option [String] :file_id A deposition file ID.
    # @options option [Hash] :deposition_file The deposition file to update.
    # @raise [ArgumentError] If the :id, :file_id, or :deposition_file arguments are blank.
    # @return [Zenodo::Resources::DepositionFile].
    def update_deposition_file(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      file_id = options[:file_id] || raise(ArgumentError, "Must supply :file_id")
      deposition_file = options[:deposition_file] || raise(ArgumentError, "Must supply :deposition_file")
      Resources::DepositionFile.parse(request(:put, "deposit/depositions/#{id}/files/#{file_id}", deposition_file))
    end

    # Delete DELETE deposit/depositions/:id/files/:file_id
    # Delete an existing deposition file resource.
    # Note, only deposition files for unpublished depositions may be deleted.
    # @param [Hash] options The options to delete a deposition's file with.
    # @options option [String, Fixnum] :id A deposition's ID.
    # @options option [String] :file_id A deposition file ID.
    # @raise [ArgumentError] If the :id or :file_id arguments are blank.
    # @return [Faraday::Response].
    def delete_deposition_file(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      file_id = options[:file_id] || raise(ArgumentError, "Must supply :file_id")
      request(:delete, "deposit/depositions/#{id}/files/#{file_id}", nil, nil)
    end
  end
end
