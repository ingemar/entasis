# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "entasis/version"

Gem::Specification.new do |s|
  s.name         = "entasis"
  s.version      = Entasis::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Ingemar Edsborn"]
  s.email        = ["ingemar@xox.se"]

  s.homepage     = "http://github.com/ingemar/entasis"
  s.summary      = %q{A few neat methods for a basic class}
  s.description  = %q{Entasis provides a few useful methods for building a basic class. Handy for models without a database.}

  s.files        = Dir.glob("lib/**/*") + %w(Gemfile entasis.gemspec HISTORY README.md LICENSE)
  s.test_files   = Dir.glob('spec/*')

  s.add_runtime_dependency 'activemodel', '~> 3.0'
  s.add_development_dependency 'rspec', '~> 2.0'
end
