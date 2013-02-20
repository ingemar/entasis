require 'active_support'
require 'active_model'

module Entasis
  extend ActiveSupport::Autoload

  autoload :Model
  autoload :Relations
  autoload :TransposeKeys
  autoload :Base
end
