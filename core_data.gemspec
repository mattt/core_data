# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'core_data/version'

Gem::Specification.new do |s|
  s.name        = 'core_data'
  s.authors     = ['Mattt Thompson']
  s.email       = 'm@mattt.me'
  s.homepage    = 'http://mattt.me'
  s.license     = 'MIT'
  s.version     = CoreData::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Core Data'
  s.description = 'Parse Core Data models.'

  s.add_development_dependency 'rake'

  s.add_dependency 'nokogiri', '~> 1.4'

  s.files         = Dir['./**/*'].reject { |file| file =~ %r{\./(bin|example|log|pkg|script|spec|test|vendor)} }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
