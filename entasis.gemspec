# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "entasis/version"

Gem::Specification.new do |s|
  s.name        = "entasis"
  s.version     = Entasis::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ingemar Edsborn"]
  s.email       = ["ingemar@elabs.se"]
  s.homepage    = "http://github.com/ingemar/entasis"
  s.summary     = %q{A few neat instance methods for Struct based classes}
  s.description = %q{Entasis provides a few very useful instance methods for Struct based classes. Handy for models without a database.}

  s.files         = Dir.glob("lib/**/*") + %w(Gemfile entasis.gemspec HISTORY README.md LICENSE)
  s.test_files    = Dir.glob('spec/*')
end
