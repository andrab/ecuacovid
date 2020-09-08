#!/usr/bin/env ruby

require 'bundler/setup'
require 'nu_plugin'

require 'ecuacovid/cargar_positivas'

class CargarPositivas < NuPlugin::Command
  AREAS = [:nacional, :provincial, :cantonal].freeze

  before_action :configurar
  after_action :operar
  silent :filter

  name 'cargar positivas'
  usage 'Carga los casos positivos'

  flag :area => [
    {Optional: ["a", "String"]}, "Area (nacional/provincial/cantonal)"
  ]

  attr_reader :app

  def initialize
    @app = Ecuacovid::CargarPositivas.new(vista: self)
    @log = []
  end

  def configurar
    begin
      area = args.area.to_sym
      app.send(area) if AREAS.include?(area)
    end unless !args.area?
  end

  def filter(registro)
    app.grabar(registro) if registro
  end

  def operar
    app.operar
  end

  def listo
    app.datos
  end

  def log(msg)
    @log << msg
  end
end

NuPlugin::JsonEntryPoint.run cmd: CargarPositivas
