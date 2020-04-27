class Criterios
  class << self
    def positivas
      #"──INFORME  SNGRE───┬───FECHA────┬───────────────────────ACEPTACION────────────────────────────────────────────┬"
      [[  :SNGRE_060_08H   ,"24/04/2020",       {casos: 22719                                                        }],
       [  :SNGRE_059_08H   ,"23/04/2020",       {casos: 11183, cantones_ingresados: 176,   cantones_sin_ingresar:  45}],
       [  :SNGRE_058_08H   ,"22/04/2020",       {casos: 10850, cantones_ingresados: 175,   cantones_sin_ingresar:  46}],
       [  :SNGRE_057_08H   ,"21/04/2020",       {casos: 10398, cantones_ingresados: 174,   cantones_sin_ingresar:  47}],
       [  :SNGRE_056_08H   ,"20/04/2020",       {casos: 10128, cantones_ingresados: 170,   cantones_sin_ingresar:  51}],
       [  :SNGRE_055_08H   ,"19/04/2020",       {casos:  9468, cantones_ingresados: 169,   cantones_sin_ingresar:  52}],
       [  :SNGRE_054_08H   ,"18/04/2020",       {casos:  9022, cantones_ingresados: 168,   cantones_sin_ingresar:  53}],
       [  :SNGRE_053_08H   ,"17/04/2020",       {casos:  8450, cantones_ingresados: 167,   cantones_sin_ingresar:  54}],
       [  :SNGRE_052_08H   ,"16/04/2020",       {casos:  8225, cantones_ingresados: 165,   cantones_sin_ingresar:  56}],
       [  :SNGRE_051_08H   ,"15/04/2020",       {casos:  7858, cantones_ingresados: 163,   cantones_sin_ingresar:  58}],
       [  :SNGRE_050_08H   ,"14/04/2020",       {casos:  7603, cantones_ingresados: 161,   cantones_sin_ingresar:  60}],
       [  :SNGRE_049_08H   ,"13/04/2020",       {casos:  7529, cantones_ingresados: 161,   cantones_sin_ingresar:  60}],
       [  :SNGRE_048_08H   ,"12/04/2020",       {casos:  7466, cantones_ingresados: 160,   cantones_sin_ingresar:  61}],
       [  :SNGRE_047_07H   ,"11/04/2020",       {casos:  7257, cantones_ingresados: 156,   cantones_sin_ingresar:  65}],
       [  :SNGRE_046_07H   ,"10/04/2020",       {casos:  7161, cantones_ingresados: 154,   cantones_sin_ingresar:  67}],
       [  :SNGRE_045_07H   ,"09/04/2020",       {casos:  4965, cantones_ingresados: 149,   cantones_sin_ingresar:  72}],
       [  :SNGRE_044_07H   ,"08/04/2020",       {casos:  4450, cantones_ingresados: 140,   cantones_sin_ingresar:  81}],
       [  :SNGRE_043_17H   ,"07/04/2020",       {casos:  3995, cantones_ingresados: 137,   cantones_sin_ingresar:  84}],
       [  :SNGRE_042_10H   ,"06/04/2020",       {casos:  3747, cantones_ingresados: 135,   cantones_sin_ingresar:  86}],
       [  :SNGRE_041_10H   ,"05/04/2020",       {casos:  3646, cantones_ingresados: 130,   cantones_sin_ingresar:  91}],
       [  :SNGRE_040_10H   ,"04/04/2020",       {casos:  3465, cantones_ingresados: 130,   cantones_sin_ingresar:  91}],
       [  :SNGRE_039_10H   ,"03/04/2020",       {casos:  3368, cantones_ingresados: 128,   cantones_sin_ingresar:  93}],
       [  :SNGRE_038_10H   ,"02/04/2020",       {casos:  3163, cantones_ingresados: 126,   cantones_sin_ingresar:  95}],
       [  :SNGRE_037_17H   ,"01/04/2020",       {casos:  2758, cantones_ingresados: 122,   cantones_sin_ingresar:  99}],
       [  :SNGRE_035_17H   ,"31/03/2020",       {casos:  2302, cantones_ingresados: 116,   cantones_sin_ingresar: 105}],
       [  :SNGRE_033_17H   ,"30/03/2020",       {casos:  1966, cantones_ingresados: 103,   cantones_sin_ingresar: 118}],
       [  :SNGRE_031_17H   ,"29/03/2020",       {casos:  1924, cantones_ingresados: 100,   cantones_sin_ingresar: 121}],
       [  :SNGRE_029_10H   ,"28/03/2020",       {casos:  1835, cantones_ingresados:  96,   cantones_sin_ingresar: 125}],
       [  :SNGRE_027_17H   ,"27/03/2020",       {casos:  1627, cantones_ingresados:  86,   cantones_sin_ingresar: 135}],
       [  :SNGRE_025_17H   ,"26/03/2020",       {casos:  1403, cantones_ingresados:  81,   cantones_sin_ingresar: 140}],
       [  :SNGRE_023_17H   ,"25/03/2020",       {casos:  1211, cantones_ingresados:  77,   cantones_sin_ingresar: 144}],
       [  :SNGRE_021_17H   ,"24/03/2020",       {casos:  1082, cantones_ingresados:  68,   cantones_sin_ingresar: 153}],
       [  :SNGRE_019_10H   ,"23/03/2020",       {casos:   981, cantones_ingresados:  58,   cantones_sin_ingresar: 163}],
       [  :SNGRE_018_10H   ,"22/03/2020",       {casos:   789, cantones_ingresados:  51,   cantones_sin_ingresar: 170}],
       [  :SNGRE_017_17H   ,"21/03/2020",       {casos:   532, cantones_ingresados:  43,   cantones_sin_ingresar: 178}],
       [  :SNGRE_015_16H   ,"20/03/2020",       {casos:   426, cantones_ingresados:  37,   cantones_sin_ingresar: 184}],
       [  :SNGRE_013_16H   ,"19/03/2020",       {casos:   260, cantones_ingresados:  26,   cantones_sin_ingresar: 195}],
       [  :SNGRE_011_13H   ,"18/03/2020",       {casos:   168, cantones_ingresados:  16,   cantones_sin_ingresar: 205}],
       [  :SNGRE_009_09H   ,"17/03/2020",       {casos:   111, cantones_ingresados:  15,   cantones_sin_ingresar: 206}],     
       [  :SNGRE_007_16H   ,"16/03/2020",       {casos:    58, cantones_ingresados:  12,   cantones_sin_ingresar: 209}],
       [  :SNGRE_005_18H   ,"15/03/2020",       {casos:    37, cantones_ingresados:  11,   cantones_sin_ingresar: 210}],
       [  :SNGRE_003_15H   ,"14/03/2020",       {casos:    28, cantones_ingresados:  10,   cantones_sin_ingresar: 211}],
       [  :SNGRE_002_17H   ,"13/03/2020",       {casos:    23, cantones_ingresados:   8,   cantones_sin_ingresar: 213}]]
    end

    def muertes
      #"──INFORME  SNGRE───┬───FECHA────┬───────────────────────ACEPTACION───────────────────────────────────────────┬"
      [#[ :SNGRE_060_08H   ,"24/04/2020", {muertes:  576                                                            }],
       [  :SNGRE_059_08H   ,"23/04/2020", {muertes:  560, provincias_ingresadas:  22,   provincias_sin_ingresar:   2}],
       [  :SNGRE_058_08H   ,"22/04/2020", {muertes:  537, provincias_ingresadas:  22,   provincias_sin_ingresar:   2}],
       [  :SNGRE_057_08H   ,"21/04/2020", {muertes:  520, provincias_ingresadas:  22,   provincias_sin_ingresar:   2}],
       [  :SNGRE_056_08H   ,"20/04/2020", {muertes:  507, provincias_ingresadas:  22,   provincias_sin_ingresar:   2}],
       [  :SNGRE_055_08H   ,"19/04/2020", {muertes:  474, provincias_ingresadas:  22,   provincias_sin_ingresar:   2}],
       [  :SNGRE_054_08H   ,"18/04/2020", {muertes:  456, provincias_ingresadas:  21,   provincias_sin_ingresar:   3}],
       [  :SNGRE_053_08H   ,"17/04/2020", {muertes:  421, provincias_ingresadas:  21,   provincias_sin_ingresar:   3}],
       [  :SNGRE_052_08H   ,"16/04/2020", {muertes:  403, provincias_ingresadas:  20,   provincias_sin_ingresar:   4}],
       [  :SNGRE_051_08H   ,"15/04/2020", {muertes:  388, provincias_ingresadas:  20,   provincias_sin_ingresar:   4}],
       [  :SNGRE_050_08H   ,"14/04/2020", {muertes:  369, provincias_ingresadas:  20,   provincias_sin_ingresar:   4}],
       [  :SNGRE_049_08H   ,"13/04/2020", {muertes:  355, provincias_ingresadas:  20,   provincias_sin_ingresar:   4}],
       [  :SNGRE_048_08H   ,"12/04/2020", {muertes:  333, provincias_ingresadas:  20,   provincias_sin_ingresar:   4}],
       [  :SNGRE_047_07H   ,"11/04/2020", {muertes:  315, provincias_ingresadas:  20,   provincias_sin_ingresar:   4}],
       [  :SNGRE_046_07H   ,"10/04/2020", {muertes:  297, provincias_ingresadas:  20,   provincias_sin_ingresar:   4}],
       [  :SNGRE_045_07H   ,"09/04/2020", {muertes:  272, provincias_ingresadas:  17,   provincias_sin_ingresar:   7}],
       [  :SNGRE_044_07H   ,"08/04/2020", {muertes:  242, provincias_ingresadas:  17,   provincias_sin_ingresar:   7}],
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

    def defunciones
      #"────────INFORME  RCIVIL───────┬───FECHA────┬──ACEPTACION───┬"
      [[  :RCIV_24_04_2020_25_04_2020 ,"25/04/2020", {muertes: 106}],
       [  :RCIV_24_04_2020_25_04_2020 ,"24/04/2020", {muertes: 223}],
       [  :RCIV_24_04_2020_25_04_2020 ,"23/04/2020", {muertes: 250}],
       [  :RCIV_24_04_2020_25_04_2020 ,"22/04/2020", {muertes: 304}],
       [  :RCIV_24_04_2020_25_04_2020 ,"21/04/2020", {muertes: 376}],
       [  :RCIV_24_04_2020_25_04_2020 ,"20/04/2020", {muertes: 431}],
       [  :RCIV_24_04_2020_25_04_2020 ,"19/04/2020", {muertes: 429}],
       [  :RCIV_24_04_2020_25_04_2020 ,"18/04/2020", {muertes: 361}],
       [  :RCIV_24_04_2020_25_04_2020 ,"17/04/2020", {muertes: 422}],
       [  :RCIV_24_04_2020_25_04_2020 ,"16/04/2020", {muertes: 448}]]
    end

    def muertes_probables
      #"──INFORME  SNGRE───┬───FECHA────┬─────────ACEPTACION────────────┬"
      [#[  :SNGRE_060_08H   ,"24/04/2020", {probables: 1060, total: 1636}],
       [  :SNGRE_059_08H   ,"23/04/2020", {probables: 1028, total: 1588}],
       [  :SNGRE_058_08H   ,"22/04/2020", {probables:  952, total: 1489}],
       [  :SNGRE_057_08H   ,"21/04/2020", {probables:  902, total: 1422}],
       [  :SNGRE_056_08H   ,"20/04/2020", {probables:  826, total: 1333}],
       [  :SNGRE_055_08H   ,"19/04/2020", {probables:  817, total: 1291}],
       [  :SNGRE_054_08H   ,"18/04/2020", {probables:  731, total: 1187}],
       [  :SNGRE_053_08H   ,"17/04/2020", {probables:  675, total: 1096}],
       [  :SNGRE_052_08H   ,"16/04/2020", {probables:  632, total: 1035}],
       [  :SNGRE_051_08H   ,"15/04/2020", {probables:  582, total:  970}],
       [  :SNGRE_050_08H   ,"14/04/2020", {probables:  436, total:  805}],
       [  :SNGRE_049_08H   ,"13/04/2020", {probables:  424, total:  779}],
       [  :SNGRE_048_07H   ,"12/04/2020", {probables:  384, total:  717}],
       [  :SNGRE_047_07H   ,"11/04/2020", {probables:  338, total:  653}],
       [  :SNGRE_046_07H   ,"10/04/2020", {probables:  311, total:  608}],
       [  :SNGRE_045_07H   ,"09/04/2020", {probables:  284, total:  556}],
       [  :SNGRE_044_17H   ,"08/04/2020", {probables:  240, total:  482}],
       [  :SNGRE_043_10H   ,"07/04/2020", {probables:  182, total:  402}],
       [  :SNGRE_042_10H   ,"06/04/2020", {probables:  173, total:  364}],
       [  :SNGRE_041_10H   ,"05/04/2020", {probables:  159, total:  339}],
       [  :SNGRE_040_10H   ,"04/04/2020", {probables:  146, total:  318}],
       [  :SNGRE_039_10H   ,"03/04/2020", {probables:  101, total:  246}],
       [  :SNGRE_038_17H   ,"02/04/2020", {probables:   78, total:  198}],
       [  :SNGRE_037_17H   ,"01/04/2020", {probables:   76, total:  174}],
       [  :SNGRE_035_17H   ,"31/03/2020", {probables:    0, total:   79}],
       [  :SNGRE_033_17H   ,"30/03/2020", {probables:    0, total:   62}],
       [  :SNGRE_031_10H   ,"29/03/2020", {probables:    0, total:   58}],
       [  :SNGRE_029_17H   ,"28/03/2020", {probables:    0, total:   48}],
       [  :SNGRE_027_17H   ,"27/03/2020", {probables:    0, total:   41}],
       [  :SNGRE_025_17H   ,"26/03/2020", {probables:    0, total:   34}]]
    end

    def con_muertes_probables
      muertes.map.each_with_index do |(de_informe, fecha, spec), idx|
        [de_informe, fecha, spec.merge(muertes_probables[idx].last)]
      end
    end
    
    def para(tema)
      self.send(tema)
    end
  end
end
