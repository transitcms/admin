# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transit/admin/version"

Gem::Specification.new do |s|
  s.name        = "transit-admin"
  s.version     = Transit::Admin::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["dev@kurbmedia.com"]
  s.homepage    = "https://github.com/transitcms/admin"
  s.summary     = %q{Administrative module for the Transit CMS engine}
  s.description = %q{Administrative backend for the Transit CME engine, with inline editing via Backbone.js}

  s.rubyforge_project = "transit-admin"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency("transit", ">= 0.1.0")
  s.add_dependency("inherited_resources", "1.3.0")
  s.add_dependency("devise", "1.5.1")  
  
  s.add_development_dependency('combustion', '~> 0.3.1')
  s.add_development_dependency("rspec", ">= 2.7.0")
  s.add_development_dependency("rspec-rails", ">= 2.7.0")
  s.add_development_dependency("rspec-rails-mocha", ">= 0.3.1")
  s.add_development_dependency("mocha", ">= 0.10.0")
  s.add_development_dependency("mongoid-rspec", "~> 1.4.4")
  s.add_development_dependency("machinist", ">= 2.0.0.beta2")
  s.add_development_dependency("coffee-rails", ">= 3.1")
  
end
