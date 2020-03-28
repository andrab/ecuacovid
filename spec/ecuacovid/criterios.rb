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
      end
    end

    class Teniendo
      def initialize(cantidad)
        @cantidad = cantidad
      end

      def y_tiene(total)
        @tendra = total
        self
      end
      
      def de(provincia)
        {
          de_las_provincias_teniendo: Hash[provincia, @tendra],
             teniendo_sin_clasificar: @sin
        }
      end
    end

    def sin_provincia(total_casos_sin_origen)
      Condicion.teniendo(total_casos_sin_origen)
    end

    class ::Integer
      def muertes
        {:muertes => self}
      end
    end

    class ::Hash
      def y(condiciones)
        self.merge!(condiciones)
      end
    end

    def positivas
      #"──INFORME SNGRE──┬───FECHA────┬───────────────────────ACEPTACION────────────────────────────────────┬"
      [[  :SNGRE_xxx     ,"25/03/2020", {casos: 1211, cantones_ingresados: 77, cantones_sin_ingresar: 144}],
       [  :SNGRE_xxx     ,"24/03/2020", {casos: 1082, cantones_ingresados: 68, cantones_sin_ingresar: 153}],
       [  :SNGRE_xxx     ,"23/03/2020", {casos:  981, cantones_ingresados: 58, cantones_sin_ingresar: 163}],
       [  :SNGRE_xxx     ,"22/03/2020", {casos:  789, cantones_ingresados: 51, cantones_sin_ingresar: 170}],
       [  :SNGRE_xxx     ,"21/03/2020", {casos:  532, cantones_ingresados: 43, cantones_sin_ingresar: 178}],
       [  :SNGRE_xxx     ,"20/03/2020", {casos:  426, cantones_ingresados: 37, cantones_sin_ingresar: 184}],
       [  :SNGRE_013     ,"19/03/2020", {casos:  260, cantones_ingresados: 26, cantones_sin_ingresar: 195}],
       [  :SNGRE_011     ,"18/03/2020", {casos:  168, cantones_ingresados: 16, cantones_sin_ingresar: 205}],
       [  :SNGRE_009     ,"17/03/2020", {casos:  111, cantones_ingresados: 15, cantones_sin_ingresar: 206}],
       [  :SNGRE_007     ,"16/03/2020", {casos:   58, cantones_ingresados: 12, cantones_sin_ingresar: 209}],
       [  :SNGRE_005     ,"15/03/2020", {casos:   37, cantones_ingresados: 11, cantones_sin_ingresar: 210}],
       [  :SNGRE_003     ,"14/03/2020", {casos:   28, cantones_ingresados: 10, cantones_sin_ingresar: 211}],
       [  :SNGRE_002     ,"13/03/2020", {casos:   23, cantones_ingresados:  8, cantones_sin_ingresar: 213}]]
    end

    def muertes
      #"──────────────────┬──FECHA───┬────────────────────────ACEPTACION───────────────────────────────────┬"
      [[                  "20/03/2020",             7.muertes.y(sin_provincia(2).y_tiene(4).de("Guayas"))],  
       [                  "19/03/2020", {muertes:   4,       de_las_provincias_teniendo: {"Manabí" => 1}}],
       [                  "18/03/2020", {muertes:   3,       de_las_provincias_teniendo: {"Guayas" => 3}}],
       [                  "17/03/2020", {muertes:                                                      2}],
       [                  "16/03/2020", {muertes:                                                      2}],
       [                  "15/03/2020", {muertes:                                                      2}],
       [                  "14/03/2020", {muertes:                                                      2}],
       [                  "13/03/2020", {muertes:   2,       de_las_provincias_teniendo: {"Guayas" => 2}}]]
    end
  end
end
