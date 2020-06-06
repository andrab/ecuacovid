module Ecuacovid
  module Utils
    class ::Array
      def reajustar
        DatosReajustador.reajustar(self)
      end
    end

    class DatosReajustador
      attr_reader :reajustados

      class << self
        def reajustar(datum)
          data = new(datum)
          data.reajustar
          data.reajustados
        end
      end

      def initialize(datum, opciones = {})
        @datum = datum
        @reajustados = opciones[:reajustados] || []
        @rastrear = opciones[:rastrear] || []
        @apuntador = opciones[:apuntador] || 0
      end

      def reajustar
        @datum.each_with_index do |value, idx|
          @numero = value

          rastrear! and listo_para_reajustar? do |reajustados|
            @reajustados += reajustados
            @apuntador = idx + 1
          end

          if valor_apuntado_es_mayor? && !rastreando?
            @apuntador = idx
          end
        end
      end

      def rastrear!
        @rastrear << @numero if valor_apuntado_es_menor?
        true
      end

      def listo_para_reajustar?(&block)
        begin
          cantidad = (@numero - @datum[@apuntador]) / (@rastrear.count + 1)
          block.call (1..@rastrear.count).map {|n| @datum[@apuntador] + (n * cantidad)}
          @reajustados << @numero
          @rastrear = []
          return
        end if valor_apuntado_es_mayor? && rastreando?
        
        persistir(@numero)
      end

      def valor_apuntado_es_mayor?
        return false if @datum[@apuntador].nil?
        @numero > @datum[@apuntador] 
      end

      def valor_apuntado_es_menor?
        return false if @datum[@apuntador].nil?
        @numero < @datum[@apuntador] 
      end

      def rastreando?
        !@rastrear.empty?
      end

      def persistir(valor)
        begin
          @reajustados << valor
          @apuntador += 1
        end if @datum[@apuntador] && !rastreando?
      end

      def reset!
        @reajustados = []
        @rastrear = []
        @apuntador = 0
        @numero = 0
      end
    end
  end
end
