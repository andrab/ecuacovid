module Ecuacovid
  module Utils
    class ::Array
      def promedio
        Promedio.para(self)
      end

      def mediana
        Mediana.para(self)
      end
    end

    class Promedio
      class << self
        def para(datum)
          data = new(datum)
          data.promedio
        end
      end

      def initialize(datum)
        @datum = datum
      end

      def promedio
        @datum.map(&:to_f).sum / @datum.size.to_f
      end
    end

    class Mediana
      class << self
        def para(datum)
          data = new(datum)
          data.mediana
        end
      end

      def initialize(datum)
        @datum = datum.sort
      end

      def par?
        @datum.size % 2 == 0
      end

      def mediana
        return @datum[mitad].to_f if !par?
        @datum[((mitad - 1)..mitad)].map(&:to_f).sum / 2.0
      end

      def mitad
        @datum.size / 2
      end
    end
  end
end
