# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'store_api/version'

Gem::Specification.new do |spec|
  spec.name          = "store_api"
  spec.version       = StoreApi::VERSION
  spec.authors       = ["tatsunori_nishikori"]
  spec.email         = ["tora.1986.tatsu@gmail.com"]
  spec.summary       = %q{Smartphone app store data acquisition API.}
  spec.description   = %q{This is the API to get the data from GooglePlay and AppStore and KindleStore and WindowsStore.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency 'simplecov', '~> 0.9.2'
  spec.add_runtime_dependency "nokogiri", '~> 1.9', '>= 1.9.1'
end
