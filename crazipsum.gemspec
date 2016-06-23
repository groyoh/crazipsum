# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crazipsum/version'

Gem::Specification.new do |spec|
  spec.name          = 'crazipsum'
  spec.version       = Crazipsum::VERSION
  spec.authors       = ['Yohan Robert']
  spec.email         = ['yohan.robert@outlook.fr']

  spec.summary       = 'Lorem ipsum remixed'
  spec.description   = 'Ever wanted some dumber, crazier (fancier?) lorem ipsum? Here you go!'
  spec.homepage      = 'https://www.github.com/groyoh/crazipsum'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '0.40.0'
  spec.add_development_dependency 'coveralls', '~> 0.8'
end
