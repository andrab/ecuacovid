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
      #"──INFORME SNGRE──┬───FECHA────┬───────────────────────ACEPTACION────────────────────────────────────┬"
      [[  :SNGRE_xxx     ,"25/03/2020", {casos: 1211, cantones_ingresados: 77,   cantones_sin_ingresar: 144}],
       [  :SNGRE_xxx     ,"24/03/2020", {casos: 1082, cantones_ingresados: 68,   cantones_sin_ingresar: 153}],
       [  :SNGRE_xxx     ,"23/03/2020", {casos:  981, cantones_ingresados: 58,   cantones_sin_ingresar: 163}],
       [  :SNGRE_xxx     ,"22/03/2020", {casos:  789, cantones_ingresados: 51,   cantones_sin_ingresar: 170}],
       [  :SNGRE_xxx     ,"21/03/2020", {casos:  532, cantones_ingresados: 43,   cantones_sin_ingresar: 178}],
       [  :SNGRE_xxx     ,"20/03/2020", {casos:  426, cantones_ingresados: 37,   cantones_sin_ingresar: 184}],
       [  :SNGRE_013     ,"19/03/2020", {casos:  260, cantones_ingresados: 26,   cantones_sin_ingresar: 195}],
       [  :SNGRE_011     ,"18/03/2020", {casos:  168, cantones_ingresados: 16,   cantones_sin_ingresar: 205}],
       [  :SNGRE_009     ,"17/03/2020", {casos:  111, cantones_ingresados: 15,   cantones_sin_ingresar: 206}],
       [  :SNGRE_007     ,"16/03/2020", {casos:   58, cantones_ingresados: 12,   cantones_sin_ingresar: 209}],
       [  :SNGRE_005     ,"15/03/2020", {casos:   37, cantones_ingresados: 11,   cantones_sin_ingresar: 210}],
       [  :SNGRE_003     ,"14/03/2020", {casos:   28, cantones_ingresados: 10,   cantones_sin_ingresar: 211}],
       [  :SNGRE_002     ,"13/03/2020", {casos:   23, cantones_ingresados:  8,   cantones_sin_ingresar: 213}]]
    end

    def muertes
      #"────┬──FECHA───┬──────────────────────────────────ACEPTACION────────────────────────────────────────┬"
      [[    "23/03/2020",              18.muertes.y(sin_provincia(9).y_tiene(3,1).de("Guayas", "Cotopaxi"))],
       [    "22/03/2020",                                                                        14.muertes],
       [    "21/03/2020",                                                                         7.muertes],                   
       [    "20/03/2020",                             7.muertes.y(sin_provincia(2).y_tiene(4).de("Guayas"))],  
       [    "19/03/2020",                                                  4.muertes.y(con(1).de("Manabí"))],
       [    "18/03/2020",                                                  3.muertes.y(con(3).de("Guayas"))],
       [    "17/03/2020",                                                                         2.muertes],
       [    "16/03/2020",                                                                         2.muertes],
       [    "15/03/2020",                                                                         2.muertes],
       [    "14/03/2020",                                                                         2.muertes],
       [    "13/03/2020",                                                  2.muertes.y(con(2).de("Guayas"))]]
    end
  end
end
