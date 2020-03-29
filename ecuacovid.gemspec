# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ecuacovid/version'

Gem::Specification.new do |gem|
  gem.name          = "Ecuacovid"
  gem.version       = Ecuacovid::VERSION
  gem.authors       = ["Andrés N. Robalino"]
  gem.email         = ["andres@androbtech.com"]
  gem.description   = "Un proyecto que te proporciona un conjunto de datos sin procesar extraído de los informes de la situación nacional frente a la Emergencia Sanitaria por el COVID-19 del Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador SNGRE."
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/andrab/ecuacovid"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "simplecov"
end
