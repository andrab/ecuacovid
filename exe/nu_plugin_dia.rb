#!/usr/bin/env ruby

require 'bundler/setup'
require 'nu_plugin'

require 'ecuacovid/defunciones_por_dia'

class DefuncionesDiarias < NuPlugin::Command
  AREAS = [:nacional, :provincial, :cantonal].freeze
  FECHAS = [:diaria, :semanal, :mensual, :anual].freeze

  before_action :configurar
  after_action :reporte
  silent :filter

  name 'defunciones'
  usage 'Carga las defunciones'

  flag :area => [
    {Optional: ["a", "String"]}, "Area (nacional/provincial/cantonal)"
  ]

  flag :fecha => [
    {Optional: ["f", "String"]}, "Fecha (diaria/semanal/mensual/anual)"
  ]

  flag :ano => [
    {Optional: ["y", "String"]}, "Año (2015/2016/2017/2018/2019/2020)"
  ]

  attr_reader :app

  def initialize
    @app = Ecuacovid::DefuncionesPorDia.new(vista: self)
    @log = []
  end

  def configurar
    area = :nacional

    begin
      fecha = args.fecha.to_sym
      app.send(fecha, args.ano? ? args.ano.to_i : 2020) if FECHAS.include?(fecha)
    end unless !args.fecha?
  end

  def filter(_); end

  def reporte
    app.diarias
  end

  def diarias_listas
    log("listo")
  end

  def log(msg)
    @log << msg
  end
end

NuPlugin::JsonEntryPoint.run cmd: DefuncionesDiarias
