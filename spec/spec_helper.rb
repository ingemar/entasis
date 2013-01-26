require "rubygems"
require "bundler/setup"

require 'entasis'

Dir.glob(File.dirname(__FILE__) + '/support/**/*.rb').each do |filename|
  require filename
end

RSpec.configure do |config|
end
