require 'date'

module Ecuacovid
  class Data
    FECHA = ->(valor) { valor.created_at.strftime("%d/%m/%Y") }
    UNO = ->(valor) { 1 }

    class << self
      def calculador(multiplicador, &formula)
        lambda do |acc, data|
          result = (acc * multiplicador)
          return result if data.nil?
          result + formula.call(data)
        end
      end
    end

    CONTEO = calculador(0) {|data| data.reduce(0) { |sum, valor| sum + valor } }
    ACUMULACION = calculador(1) { |data| data.reduce(0) { |sum, valor| sum + valor } }
    
    MEDIA_MOVIL = ->(acc, data) {
      result = PromedioMovil.new(acc)
      result << data.shift
      result
    }
    
    def agrupar(datum, options = {})
      fn = to_lambda(options[:por]) || FECHA
  
      {}.tap do |groups|
        datum.each do |data|
          fetch(groups, fn.(data), []) {|c| c << data}
        end
      end
    end

    def dividir(grupos, divisor)
      return {predeterminado: grupos} if not divisor

      {}.tap do |divisiones|
        grupos.each_pair do |grupo, dataset|
          agrupar(dataset, por: divisor).each_pair do |division, subset|
            key = division
            fetch(divisiones, key, {}) {|c| c[grupo] = subset}
          end
        end
      end
    end

    def ordenar(las_divisiones, los_grupos, divisiones)
      las_divisiones.map do |division|
        grupos = divisiones[division]
        los_grupos.map {|nombre_grupo| grupos[nombre_grupo] || []}
      end
    end

    def evaluar(datasets, options = {})
      valores_para = to_lambda(options[:evaluar_por]) || UNO

      datasets.map do |subsets|
        subsets.map do |data|
          data.nil? ? [] : (data.map &valores_para)
        end
      end
    end

    def reducir(datasets, options = {})
      valores_para = to_lambda(options[:reducir_por]) || CONTEO

      datasets.map do |subsets|
        acc = 0
        subsets.map do |data|
          acc = valores_para.(acc, data)
        end
      end
    end
   
    def fechas(groups, options = {})
      keys = groups.keys.sort {|a,b| DateTime.parse(a) <=> DateTime.parse(b)}
       
      fn = options.fetch(:label) { PorDia }
      date = fn.(DateTime.parse(keys.first))
      end_date = DateTime.parse(keys.last)

      [].tap do |labels|
        while date <= end_date
          labels << date.to_s
          date >> 1
        end
      end
    end

    def maxima(reducidas, options = {})
      reducidas.map {|set| set.max}.max
    end

    def minima(reducidas, options = {})
      reducidas.map {|set| set.min}.min
    end

    def porcentajes(max, valores)
      valores.map do |subset|
        subset.map {|total| total * 100.0 / max}
      end
    end
  
    private
    def to_lambda expression
      return ->(value) { value[expression] } if to_lambda?(expression)
      expression
    end
  
    def to_lambda? expression
      expression.kind_of?(Symbol)
    end
  
    def fetch hash, key, default
      collection = hash.fetch(key, default)
      yield(collection) 
      hash.store(key, collection)
    end
  
    class FechaPorDia
      def initialize(d)
        @d = d
      end
      
      def to_s
        @d.strftime("%d/%m/%Y")
      end
  
      def >>(other)
        @d = @d.next_day(other)
      end
  
      def <=(other)
        @d <= other
      end
    end

    class FechaPorMes
      def initialize(d)
        @d = d
      end

      def to_s
        @d.strftime("%b-%Y")
      end

      def >>(other)
        @d = @d >> other
      end

      def <=(other)
        @d <= other
      end
    end

    class FechaPorSemana
      def initialize(d)
        @d = d
      end

      def to_s
        @d.strftime("%V")
      end

      def >>(other)
        @d = @d >> other
      end

      def <=(other)
        @d <= other
      end
    end

    class PromedioMovil
      attr_reader :dias, :total
  
      def initialize(movil)
        if movil == 0
          @acc, @dias = nil, []
        else 
          @dias = movil.dias.dup
        end
      end
  
      def <<(dia)
        dias.shift if lleno?
        @dias << dia
      end
  
      def +(movil)
        total.nil? ? nil : total + movil
      end
  
      def total
        lleno? ? @dias.map(&:total).sum / n.to_f : nil
      end

      private
      def lleno?
        @dias.size == n
      end

      def n
        7
      end
    end
    
    PorDia = ->(fecha) { FechaPorDia.new(fecha) }
    PorMes = ->(fecha) { FechaPorMes.new(fecha) }
    PorSemana = ->(fecha) { FechaPorSemana.new(fecha) }
  end
end