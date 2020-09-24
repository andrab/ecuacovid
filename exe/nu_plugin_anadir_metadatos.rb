#!/usr/bin/env ruby

require 'bundler/setup'
require 'nu_plugin'

require 'ecuacovid/anadir_metadatos'

class AnadirMetadatos < NuPlugin::Command
  name 'metadatos añadir'
  usage 'Añade metadatos'

  attr_reader :app

  def initialize
    @app = Ecuacovid::AnadirMetadatos.new(vista: self)
    @log = []
  end

  def filter(registro)
    app.anadir_metadatos(registro)
  end

  def metadatos_listo
    app.registro
  end

  def log(msg)
    @log << msg
  end
end

NuPlugin::JsonEntryPoint.run cmd: AnadirMetadatos
