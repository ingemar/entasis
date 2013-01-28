require 'active_support'
require 'active_model'

module Entasis
  extend ActiveSupport::Autoload

  autoload :Model
  autoload :TransposeKeys
  autoload :Base
end
