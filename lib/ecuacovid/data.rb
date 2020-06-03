module Ecuacovid
  class Data
    FECHA = ->(valor) { valor.created_at.strftime("%d/%m/%Y") }
    UNO = ->(valor) { 1 }

    CONTEO = ->(acc, data) {
      result = acc * 0
      return result if data.nil?
      result + data.reduce(0) { |sum, value| sum + value }
    }
  
    ACUMULACION = ->(acc, data) {
      result = (acc * 1)
      return result if data.nil?
      result + data.reduce(0) { |sum, value| sum + value }
    }
    
    def agrupar(datum, options = {})
      fn = to_lambda(options[:por]) || FECHA
  
      {}.tap do |groups|
        datum.each do |data|
          fetch(groups, fn.(data), []) {|c| c << data}
        end
      end
    end

    def dividir(grupos, options = {})
      return {predeterminado: grupos} if not options[:por]

      {}.tap do |divisiones|
        grupos.each_pair do |grupo, dataset|
          agrupar(dataset, options).each_pair do |division, subset|
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
    
    PorDia = ->(fecha) { FechaPorDia.new(fecha) }
    PorMes = ->(fecha) { FechaPorMes.new(fecha) }
  end
end