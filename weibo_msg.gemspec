# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weibo_msg/version'

Gem::Specification.new do |spec|
  spec.name          = "weibo_msg"
  spec.version       = WeiboMsg::VERSION
  spec.authors       = ["Chencheng Zhang"]
  spec.email         = ["chencheng.zhang@gmail.com"]
  spec.summary       = %q{Rack middleware for weibo followers service}
  spec.description   = %q{Rack middleware for weibo followers service}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'rake'
  spec.add_dependency 'multi_json'
  spec.add_dependency 'nestful'
  spec.add_dependency 'hashie'
  spec.add_dependency 'mini_magick'
  spec.add_dependency 'carrierwave'
end
