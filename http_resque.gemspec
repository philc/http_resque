# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "http_resque/version"

Gem::Specification.new do |s|
  s.name        = "http_resque"
  s.version     = HttpResque::VERSION
  s.authors     = ["Phil Crosby"]
  s.email       = ["phil.crosby@gmail.com"]
  s.homepage    = "http://github.com/philc/http_resque"
  s.summary     = "Schedule and test Resque jobs using HTTP requests."
  s.description = "http_resque helps you cleanly write integration tests for your Resque jobs. It's a thin " +
      "HTTP API around the Resque daemon. With it you can manipulate the contents of the Resque queues " +
      "using HTTP requests."

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
  s.add_runtime_dependency "trollop"
end
