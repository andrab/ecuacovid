module Ecuacovid
  module Utils
    module Visualizaciones
      [
       [:azuay           ,  10],
       [:ecuador         , 150],
       [:bolivar         ,   1],
       [:canar           ,   1],
       [:carchi          ,   1],
       [:imbabura        ,   4],
       [:chimborazo      ,   5],
       [:cotopaxi        ,   4],
       [:el_oro          ,   6],
       [:los_rios        ,   5],
       [:loja            ,   6],
       [:esmeraldas      ,   3],
       [:galapagos       ,   0],
       [:guayas          ,   0],
       [:pichincha       ,  30],
       [:manabi          ,  10], 
       [:morona_santiago ,   1],
       [:napo            ,   1],
       [:orellana        ,   0],
       [:pastaza         ,   0],
       [:tungurahua      ,   6],
       [:santa_elena     ,   0],
       [:santo_domingo   ,   5],
       [:sucumbios       ,   1],
       [:zamora_chinchipe,   1]
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