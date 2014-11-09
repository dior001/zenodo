require 'zenodo'

module Zenodo
  module DSL
  end
end

require 'zenodo/dsl/depositions'

module Zenodo
  module DSL
    include Depositions
  end
end

