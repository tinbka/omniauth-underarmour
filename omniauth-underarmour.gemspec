# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-underarmour/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-underarmour"
  s.version     = OmniAuth::Underarmour::VERSION
  s.authors     = ["Sergey Baev"]
  s.email         = ["tinbka@gmail.com"]
  s.homepage    = "https://github.com/tinbka/omniauth-underarmour"
  s.summary     = %q{OmniAuth OAuth2 strategy for UnderArmour}
  s.description = %q{OmniAuth OAuth2 strategy for UnderArmour}

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.4'
  s.add_runtime_dependency 'multi_xml'
end