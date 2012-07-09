Gem::Specification.new do |s|
  s.name        = 'checker'
  s.version     = '0.0.4.2'
  s.date        = '2012-07-09'
  s.summary     = "Syntax checker for various files"
  s.description = "A collection of modules which every is designed to check syntax for specific files."
  s.authors     = ["Jacek Jakubik"]
  s.email       = 'jacek.jakubik@netguru.pl'
  s.files       = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage    = 'http://github.com/netguru/checker'
  s.add_dependency 'colorize', '0.5.8'
end
