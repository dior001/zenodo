require 'zenodo/dsl'

module Zenodo
  module DSL::DepositionFiles
    # List GET deposit/depositions/:id/files
    # List all deposition files for a given deposition.
    # @param [String, Fixnum] id A deposition's ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Array, nil].
    def get_deposition_files(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      Resources::DepositionFile.parse(request(:get, "deposit/depositions/#{id}/files", nil))
    end

    # Create (upload) POST deposit/depositions/:id/files
    # Upload a new file.
    # Note the upload will fail if the filename already exists.
    # @param [String, Fixnum] id A deposition's ID.
    # @param [String] file_or_io The file or already open IO to upload.
    # @param [String] filename The name of the file (optional except when an IO).
    # @param [String] content_type The content type of the file (optional except when an IO).
    # @raise [ArgumentError] If the required method arguments are blank.
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
    # @param [String, Fixnum] id A deposition's ID.
    # @param [Array] deposition_files The deposition files to sort.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Array, nil].
    def sort_deposition_files(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      deposition_files = options[:deposition_files] || raise(ArgumentError, "Must supply :deposition_files")

      raise ArgumentError, "ID cannot be blank" if id.blank?
      raise ArgumentError, "Deposition files cannot be blank" if deposition_files.blank?
      Resources::DepositionFile.parse(request(:put, "deposit/depositions/#{id}/files", deposition_files))
    end

    # Retrieve GET deposit/depositions/:id/files/:file_id
    # Retrieve a single deposition file.
    # @param [String, Fixnum] id A deposition's ID.
    # @param [String] file_id A deposition file ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Zenodo::Resources::DepositionFile].
    def get_deposition_file(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      file_id = options[:file_id] || raise(ArgumentError, "Must supply :file_id")
      Resources::DepositionFile.parse(request(:get, "deposit/depositions/#{id}/files/#{file_id}", nil))
    end

    # Update PUT deposit/depositions/:id/files/:file_id
    # Update a deposition file resource. Currently the only use is renaming an already uploaded file.
    # If you one to replace the actual file, please delete the file and upload a new file.
    # @param [String, Fixnum] id A deposition's ID.
    # @param [String] file_id A deposition file ID.
    # @param [Hash] deposition_file The deposition file to update.
    # @raise [ArgumentError] If the method arguments are blank.
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
    # @param [String, Fixnum] id A deposition's ID.
    # @param [String] file_id A deposition file ID.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Faraday::Response].
    def delete_deposition_file(options={})
      id = options[:id] || raise(ArgumentError, "Must supply :id")
      file_id = options[:file_id] || raise(ArgumentError, "Must supply :file_id")
      request(:delete, "deposit/depositions/#{id}/files/#{file_id}", nil, nil)
    end
  end
end
