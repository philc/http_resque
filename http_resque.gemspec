# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "http_resque/version"

Gem::Specification.new do |s|
  s.name        = "http_resque"
  s.version     = HttpResque::VERSION
  s.authors     = ["Phil Crosby"]
  s.email       = ["phil.crosby@gmail.com"]
  s.homepage    = "http://github.com/philc/http_resque"
  s.summary     = "A small HTTP wrapper around Resque, so you can schedule and test jobs over HTTP."

  s.rubyforge_project = "http_resque"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "thin"
  s.add_runtime_dependency "resque"
  s.add_runtime_dependency "rake"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "sinatra"
end
