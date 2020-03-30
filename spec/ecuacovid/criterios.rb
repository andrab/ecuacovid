class Criterios
  class << self
    def para(tema)
      self.send(tema)
    end

    class Condicion
      class << self
        def teniendo(sujeto)
          Teniendo.new(sujeto)
        end

        def teniendo_provincias_totales(sujeto)
          TeniendoProvincias.new(sujeto)
        end
      end
    end

    class TeniendoProvincias
      def initialize(cantidad)
        @cantidad = cantidad
      end

      def de(provincia)
        {
          de_las_provincias_teniendo: Hash[provincia, @cantidad],
          teniendo_sin_clasificar: 0
        }
      end
    end

    class Teniendo
      def initialize(cantidad)
        @cantidad = cantidad
      end

      def y_tiene(*totales)
        @tendra = totales
        self
      end
      
      def de(*provincias)
        {
          de_las_provincias_teniendo: provincias.zip(@tendra),
             teniendo_sin_clasificar: @cantidad
        }
      end
    end

    def sin_provincia(total_casos_sin_origen)
      Condicion.teniendo(total_casos_sin_origen)
    end

    def con(total_casos_de_provincia)
      Condicion.teniendo_provincias_totales(total_casos_de_provincia)
    end

    class ::Integer
      def muertes
        Hash[:muertes, self]
      end
    end

    class ::Hash
      def y(condiciones)
        self.merge!(condiciones)
      end
    end

    def positivas
      #"──INFORME  SNGRE───┬───FECHA────┬───────────────────────ACEPTACION────────────────────────────────────┬"
      [[  :SNGRE_032_10H   ,"30/03/2020", {casos: 1962, cantones_ingresados: 103,   cantones_sin_ingresar: 118}],
       [  :SNGRE_031_17H   ,"29/03/2020", {casos: 1924, cantones_ingresados: 100,   cantones_sin_ingresar: 121}],
       [  :SNGRE_029_10H   ,"28/03/2020", {casos: 1835, cantones_ingresados:  96,   cantones_sin_ingresar: 125}],
       [  :SNGRE_027_17H   ,"27/03/2020", {casos: 1627, cantones_ingresados:  86,   cantones_sin_ingresar: 135}],
       [  :SNGRE_025_17H   ,"26/03/2020", {casos: 1403, cantones_ingresados:  81,   cantones_sin_ingresar: 140}],
       [  :SNGRE_023_17H   ,"25/03/2020", {casos: 1211, cantones_ingresados:  77,   cantones_sin_ingresar: 144}],
       [  :SNGRE_021_17H   ,"24/03/2020", {casos: 1082, cantones_ingresados:  68,   cantones_sin_ingresar: 153}],
       [  :SNGRE_019_10H   ,"23/03/2020", {casos:  981, cantones_ingresados:  58,   cantones_sin_ingresar: 163}],
       [  :SNGRE_018_10H   ,"22/03/2020", {casos:  789, cantones_ingresados:  51,   cantones_sin_ingresar: 170}],
       [  :SNGRE_017_17H   ,"21/03/2020", {casos:  532, cantones_ingresados:  43,   cantones_sin_ingresar: 178}],
       [  :SNGRE_015_16H   ,"20/03/2020", {casos:  426, cantones_ingresados:  37,   cantones_sin_ingresar: 184}],
       [  :SNGRE_013_16H   ,"19/03/2020", {casos:  260, cantones_ingresados:  26,   cantones_sin_ingresar: 195}],
       [  :SNGRE_011_13H   ,"18/03/2020", {casos:  168, cantones_ingresados:  16,   cantones_sin_ingresar: 205}],
       [  :SNGRE_009_09H   ,"17/03/2020", {casos:  111, cantones_ingresados:  15,   cantones_sin_ingresar: 206}],     
       [  :SNGRE_007_16H   ,"16/03/2020", {casos:   58, cantones_ingresados:  12,   cantones_sin_ingresar: 209}],
       [  :SNGRE_005_18H   ,"15/03/2020", {casos:   37, cantones_ingresados:  11,   cantones_sin_ingresar: 210}],
       [  :SNGRE_003_15H   ,"14/03/2020", {casos:   28, cantones_ingresados:  10,   cantones_sin_ingresar: 211}],
       [  :SNGRE_002_17H   ,"13/03/2020", {casos:   23, cantones_ingresados:   8,   cantones_sin_ingresar: 213}]]
    end

    def muertes
      #"──INFORME  SNGRE───┬───FECHA────┬───────────────────────ACEPTACION────────────────────────────────────┬"
      [[  :SNGRE_032_10H   ,"30/03/2020",                                                            60.muertes],
       [  :SNGRE_031_17H   ,"29/03/2020",                                                            58.muertes],
       [  :SNGRE_029_10H   ,"28/03/2020",                                                            48.muertes],
       [  :SNGRE_027_17H   ,"27/03/2020",                                                            41.muertes],
       [  :SNGRE_025_17H   ,"26/03/2020",                                                            34.muertes],
       [  :SNGRE_023_17H   ,"25/03/2020",                                                            29.muertes],
       [  :SNGRE_021_17H   ,"24/03/2020",                                                            27.muertes],
       [  :SNGRE_019_10H   ,"23/03/2020",  18.muertes.y(sin_provincia(9).y_tiene(3,1).de("Guayas", "Cotopaxi"))],
       [  :SNGRE_018_10H   ,"22/03/2020",                                                            14.muertes],
       [  :SNGRE_017_17H   ,"21/03/2020",                                                             7.muertes],
       [  :SNGRE_015_16H   ,"20/03/2020",                 7.muertes.y(sin_provincia(2).y_tiene(4).de("Guayas"))],
       [  :SNGRE_013_16H   ,"19/03/2020",                                      4.muertes.y(con(1).de("Manabí"))],
       [  :SNGRE_011_13H   ,"18/03/2020",                                      3.muertes.y(con(3).de("Guayas"))],
       [  :SNGRE_009_09H   ,"17/03/2020",                                                             2.muertes],     
       [  :SNGRE_007_16H   ,"16/03/2020",                                                             2.muertes],
       [  :SNGRE_005_18H   ,"15/03/2020",                                                             2.muertes],
       [  :SNGRE_003_15H   ,"14/03/2020",                                                             2.muertes],
       [  :SNGRE_002_17H   ,"13/03/2020",                                      2.muertes.y(con(2).de("Guayas"))]]
    end
  end
end
