# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-piface"
  s.version     = "0.1.0"
  s.authors     = ["elvisimprsntr"]
  s.email       = [""]
  s.homepage    = "https://github.com/elvisimprsntr/siriproxy-piface"
  s.summary     = %q{SiriProxy plugin for the Raspberry Pi GPIO PiFace Digital expansion board}
  s.description = %q{SiriProxy plugin for the Raspberry Pi GPIO PiFace Digital expansion board}

  s.rubyforge_project = ""

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "siriproxy", ">=0.5.2"
  s.add_runtime_dependency "PiFace"


end
