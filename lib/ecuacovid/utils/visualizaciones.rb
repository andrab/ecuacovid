module Ecuacovid
  module Utils
    module Visualizaciones
      [
       [:guayas     ,   0],
       [:pichincha  ,  30],
       [:manabi     ,  10], 
       [:tungurahua ,   6],
       [:santa_elena,   0],
       [:ecuador    , 150]
      ].each do |propiedades|
        provincia, min = propiedades

        define_method "#{provincia.to_s}" do |options|
          {min: min}.merge(options)
        end
      end
    end
  end
end