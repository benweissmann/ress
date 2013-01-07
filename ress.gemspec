# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ress/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ben Weissmann"]
  gem.email         = ["benweissmann@gmail.com"]
  gem.description   = %q{An elegant Ruby DSL for writing CSS.}
  gem.summary       = %q{CSS in Ruby}
  gem.homepage      = "https://github.com/benweissmann/ress"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ress"
  gem.require_paths = ["lib"]
  gem.version       = Ress::VERSION
end
