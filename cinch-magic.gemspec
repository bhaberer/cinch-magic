# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/plugins/magic/version'

Gem::Specification.new do |gem|
  gem.name          = 'cinch-magic'
  gem.version       = Cinch::Plugins::Magic::VERSION
  gem.authors       = ['Brian Haberer']
  gem.email         = ['bhaberer@gmail.com']
  gem.description   = %q{Cinch Plugin that searches http://magiccards.info/ for card information.}
  gem.summary       = %q{Cinch Plugin for Magic Cards}
  gem.homepage      = 'https://github.com/bhaberer/cinch-magic'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency  'rake'
  gem.add_development_dependency  'rspec'
  gem.add_development_dependency  'coveralls'
  gem.add_development_dependency  'cinch-test'

  gem.add_dependency              'cinch',           '~> 2.0.12'
  gem.add_dependency              'cinch-toolbox',   '~> 1.1.0'
  gem.add_dependency              'cinch-cooldown',  '~> 1.1.1'
end
