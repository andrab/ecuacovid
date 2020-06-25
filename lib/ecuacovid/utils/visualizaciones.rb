module Ecuacovid
  module Utils
    module Visualizaciones
      [
       [:azuay         ,   10],
       [:guayas        ,    0],
       [:pichincha     ,   30],
       [:manabi        ,   10], 
       [:tungurahua    ,    6],
       [:santa_elena   ,    0],
       [:ecuador       ,  150],
       [:santo_domingo ,    6]
      ].each do |propiedades|
        provincia, min = propiedades

        define_method "#{provincia.to_s}" do |options|
          {min: min}.merge(options)
        end
      end

      def marcador(maximo = 2)
        veces = 0
    
        lambda do 
          return false if veces == maximo
          veces = veces + 1
          true
        end
      end
    end
  end
end