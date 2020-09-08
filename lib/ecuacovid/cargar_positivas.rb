require "ecuacovid/cliente"
require "ecuacovid/data"

module Ecuacovid
  class CargarPositivas

    attr_reader :datos
    
    def initialize(options={})
      @vista = options[:vista]
      @cliente = options[:cliente] || Ecuacovid::Cliente.new
      @datos = []
    end

    def grabar(registro)
      (@datos ||= []) << registro
    end

    def nacional
      @area = :nacional
      log("Area nacional seleccionada.")
    end

    def provincial
      @area = :provincial
      log("Area provincial seleccionada.")
    end

    def cantonal
      @area = :cantonal
      log("Area cantonal seleccionada.")
    end

    def operar
      @datos = @cliente.positivas(predicados: [[:area, :igual, area]]) if !hay_datos?
      @vista.listo
    end 

    def hay_datos?
      !@datos.empty?
    end

    private
    def area
      @area || :nacional
    end

    def log(msg)
      @vista.log(msg)
    end
  end
end
  