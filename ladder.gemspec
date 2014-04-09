# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ladder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Greget"]
  gem.email         = ["rgreget@gmail.com"]
  gem.description   = %q{Street Fighter ELO Point Ladder}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ladder"
  gem.require_paths = ["lib"]
  gem.version       = Ladder::VERSION

  gem.add_dependency "sinatra"
  gem.add_dependency "haml"
  gem.add_dependency "json"
  gem.add_dependency "sqlite3"
  gem.add_dependency "sequel"
  gem.add_dependency "unicorn"
  gem.add_dependency "omniauth"
  gem.add_dependency "omniauth-twitter"
  gem.add_development_dependency "rspec"
end
