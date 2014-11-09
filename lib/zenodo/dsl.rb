require 'zenodo'

module Zenodo
  module DSL
  end
end

require 'zenodo/dsl/depositions'
require 'zenodo/dsl/deposition_files'
require 'zenodo/dsl/deposition_actions'
require 'zenodo/utils'

module Zenodo
  module DSL
    include Depositions
    include DepositionFiles
    include DepositionActions
    include Utils
  end
end

