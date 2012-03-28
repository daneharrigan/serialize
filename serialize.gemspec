# -*- encoding: utf-8 -*-
require File.expand_path('../lib/serialize/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dane Harrigan"]
  gem.email         = ["dane.harrigan@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "serialize"
  gem.require_paths = ["lib"]
  gem.version       = Serialize::VERSION

  gem.add_runtime_dependency "json"
  gem.add_runtime_dependency "activesupport"
  gem.add_runtime_dependency "builder"
end
