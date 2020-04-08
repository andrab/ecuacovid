class Criterios
  class << self
    def positivas
      #"──INFORME  SNGRE───┬───FECHA────┬───────────────────────ACEPTACION────────────────────────────────────────────┬"
      [[  :SNGRE_044_07H   ,"08/04/2020",       {casos: 4450, cantones_ingresados: 140,   cantones_sin_ingresar:  81}],
       [  :SNGRE_043_17H   ,"07/04/2020",       {casos: 3995, cantones_ingresados: 137,   cantones_sin_ingresar:  84}],
       [  :SNGRE_042_10H   ,"06/04/2020",       {casos: 3747, cantones_ingresados: 135,   cantones_sin_ingresar:  86}],
       [  :SNGRE_041_10H   ,"05/04/2020",       {casos: 3646, cantones_ingresados: 130,   cantones_sin_ingresar:  91}],
       [  :SNGRE_040_10H   ,"04/04/2020",       {casos: 3465, cantones_ingresados: 130,   cantones_sin_ingresar:  91}],
       [  :SNGRE_039_10H   ,"03/04/2020",       {casos: 3368, cantones_ingresados: 128,   cantones_sin_ingresar:  93}],
       [  :SNGRE_038_10H   ,"02/04/2020",       {casos: 3163, cantones_ingresados: 126,   cantones_sin_ingresar:  95}],
       [  :SNGRE_037_17H   ,"01/04/2020",       {casos: 2758, cantones_ingresados: 122,   cantones_sin_ingresar:  99}],
       [  :SNGRE_035_17H   ,"31/03/2020",       {casos: 2302, cantones_ingresados: 116,   cantones_sin_ingresar: 105}],
       [  :SNGRE_033_17H   ,"30/03/2020",       {casos: 1966, cantones_ingresados: 103,   cantones_sin_ingresar: 118}],
       [  :SNGRE_031_17H   ,"29/03/2020",       {casos: 1924, cantones_ingresados: 100,   cantones_sin_ingresar: 121}],
       [  :SNGRE_029_10H   ,"28/03/2020",       {casos: 1835, cantones_ingresados:  96,   cantones_sin_ingresar: 125}],
       [  :SNGRE_027_17H   ,"27/03/2020",       {casos: 1627, cantones_ingresados:  86,   cantones_sin_ingresar: 135}],
       [  :SNGRE_025_17H   ,"26/03/2020",       {casos: 1403, cantones_ingresados:  81,   cantones_sin_ingresar: 140}],
       [  :SNGRE_023_17H   ,"25/03/2020",       {casos: 1211, cantones_ingresados:  77,   cantones_sin_ingresar: 144}],
       [  :SNGRE_021_17H   ,"24/03/2020",       {casos: 1082, cantones_ingresados:  68,   cantones_sin_ingresar: 153}],
       [  :SNGRE_019_10H   ,"23/03/2020",       {casos:  981, cantones_ingresados:  58,   cantones_sin_ingresar: 163}],
       [  :SNGRE_018_10H   ,"22/03/2020",       {casos:  789, cantones_ingresados:  51,   cantones_sin_ingresar: 170}],
       [  :SNGRE_017_17H   ,"21/03/2020",       {casos:  532, cantones_ingresados:  43,   cantones_sin_ingresar: 178}],
       [  :SNGRE_015_16H   ,"20/03/2020",       {casos:  426, cantones_ingresados:  37,   cantones_sin_ingresar: 184}],
       [  :SNGRE_013_16H   ,"19/03/2020",       {casos:  260, cantones_ingresados:  26,   cantones_sin_ingresar: 195}],
       [  :SNGRE_011_13H   ,"18/03/2020",       {casos:  168, cantones_ingresados:  16,   cantones_sin_ingresar: 205}],
       [  :SNGRE_009_09H   ,"17/03/2020",       {casos:  111, cantones_ingresados:  15,   cantones_sin_ingresar: 206}],     
       [  :SNGRE_007_16H   ,"16/03/2020",       {casos:   58, cantones_ingresados:  12,   cantones_sin_ingresar: 209}],
       [  :SNGRE_005_18H   ,"15/03/2020",       {casos:   37, cantones_ingresados:  11,   cantones_sin_ingresar: 210}],
       [  :SNGRE_003_15H   ,"14/03/2020",       {casos:   28, cantones_ingresados:  10,   cantones_sin_ingresar: 211}],
       [  :SNGRE_002_17H   ,"13/03/2020",       {casos:   23, cantones_ingresados:   8,   cantones_sin_ingresar: 213}]]
    end

    def muertes
      #"──INFORME  SNGRE───┬───FECHA────┬───────────────────────ACEPTACION───────────────────────────────────────────┬"
      [[  :SNGRE_044_07H   ,"08/04/2020", {muertes:  242, provincias_ingresadas:  17,   provincias_sin_ingresar:   7}],
       [  :SNGRE_043_17H   ,"07/04/2020", {muertes:  220, provincias_ingresadas:  16,   provincias_sin_ingresar:   8}],
       [  :SNGRE_042_10H   ,"06/04/2020", {muertes:  191, provincias_ingresadas:  16,   provincias_sin_ingresar:   8}],
       [  :SNGRE_041_10H   ,"05/04/2020", {muertes:  180, provincias_ingresadas:  16,   provincias_sin_ingresar:   8}],
       [  :SNGRE_040_10H   ,"04/04/2020", {muertes:  172, provincias_ingresadas:  16,   provincias_sin_ingresar:   8}],
       [  :SNGRE_039_10H   ,"03/04/2020", {muertes:  145, provincias_ingresadas:  14,   provincias_sin_ingresar:  10}],
       [  :SNGRE_038_10H   ,"02/04/2020", {muertes:  120, provincias_ingresadas:  13,   provincias_sin_ingresar:  11}],
       [  :SNGRE_037_17H   ,"01/04/2020", {muertes:   98, provincias_ingresadas:  12,   provincias_sin_ingresar:  12}],
       [  :SNGRE_035_17H   ,"31/03/2020", {muertes:   79, provincias_ingresadas:  11,   provincias_sin_ingresar:  13}],
       [  :SNGRE_033_17H   ,"30/03/2020", {muertes:   62, provincias_ingresadas:  11,   provincias_sin_ingresar:  13}],
       [  :SNGRE_031_17H   ,"29/03/2020", {muertes:   58, provincias_ingresadas:  11,   provincias_sin_ingresar:  13}],
       [  :SNGRE_029_10H   ,"28/03/2020", {muertes:   48, provincias_ingresadas:   9,   provincias_sin_ingresar:  15}],
       [  :SNGRE_027_17H   ,"27/03/2020", {muertes:   41, provincias_ingresadas:   9,   provincias_sin_ingresar:  15}],
       [  :SNGRE_025_17H   ,"26/03/2020", {muertes:   34, provincias_ingresadas:   7,   provincias_sin_ingresar:  17}]]
    end
    
    def para(tema)
      self.send(tema)
    end
  end
end
