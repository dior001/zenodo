require 'zenodo'

module Zenodo
  module DSL
  end
end

require 'zenodo/dsl/depositions'
require 'zenodo/utils'

module Zenodo
  module DSL
    include Depositions
    include Utils
  end
end

