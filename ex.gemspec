# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ex/version'

Gem::Specification.new do |spec|
  spec.name          = "ex"
  spec.version       = Ex::VERSION
  spec.authors       = ["Elliott Hilaire"]
  spec.email         = ["elliott.hilaire@gmail.com"]

  spec.summary       = "An experiment to make Ruby look like Elixir without abiding by any rules."
  spec.description   = "An experiment to make Ruby look like Elixir without abiding by any rules. Why? No reason. What practical application does this have? None."
  spec.homepage      = "https://github.com/elliotthilaire/ex"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ex-string", "~> 0.2.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
