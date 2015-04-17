# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'store_api/version'

Gem::Specification.new do |spec|
  spec.name          = "store_api"
  spec.version       = StoreApi::VERSION
  spec.authors       = ["tatsunori_nishikori"]
  spec.email         = ["tora.1986.tatsu@gmail.com"]
  spec.summary       = %q{Store Api for ruby}
  spec.description   = %q{GooglePlay,AppStore to api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "nokogiri", "~> 1.6.6.2"
end
