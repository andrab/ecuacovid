[![Travis Build Status](https://travis-ci.org/andrab/ecuacovid.svg?branch=master)](https://travis-ci.org/andrab/ecuacovid)
[![Maintainability](https://api.codeclimate.com/v1/badges/2e4a49500559587cbc5f/maintainability)](https://codeclimate.com/github/andrab/ecuacovid/maintainability)
[![Discord](https://img.shields.io/discord/693754947040444436.svg?logo=discord)](https://discord.gg/WnS2ss)
[![@cococoronata](https://img.shields.io/badge/twitter-@cococoronata-1DA1F3?style=flat-square)](https://twitter.com/cococoronata)

# Ecuacovid

Un proyecto que te proporciona un conjunto de datos sin procesar extraído [de los informes](informes/) de la situación nacional frente a la Emergencia Sanitaria por el COVID-19 del Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador (SNGRE), Ministerio de Salud Pública del Ecuador (MSP), y Registro Civil del Ecuador.

# Información

Puedes ver los archivos en la carpeta `datos_crudos` [aquí](datos_crudos/). Contienen lo siguiente:

[ecuacovid.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid.json)] (`muestras`,`muestras_pcr`,`muestras_pcr_nuevas`,`pruebas_rezagadas`,`muertes_confirmadas`,`muertes_probables`,`muertes`,`muertes_nuevas`,`positivas`,`positivas_pcr`,`positivas_pcr_nuevas`,`positivas_rapidas`,`negativas`,`negativas_pcr`,`negativas_pcr_nuevas`,`negativas_rapidas`,`defunciones`, `defunciones_nuevas`, `defunciones_2019`, `defunciones_2019_nuevas`, `defunciones_2018`, `defunciones_2018_nuevas`, `defunciones_2017`, `defunciones_2017_nuevas`, `defunciones_2016`, `defunciones_2016_nuevas`, `defunciones_2015`, `defunciones_2015_nuevas`, `hospitalizadas_altas`,`hospitalizadas_estables`,`hospitalizadas_pronostico_reservadas`,`created_at`) donde:

* `muestras` = Muestras tomadas entre PCR y pruebas rápidas
* `muestras_pcr` = Muestras tomadas para RT-PCR
* `muestras_pcr_nuevas` = El número de nuevas muestras
* `pruebas_rezagadas` = Pruebas rezagadas
* `muertes_confirmadas` = El total de muertes confirmadas
* `muertes_probables` = El total de muertes probables
* `muertes` = El total de muertes confirmadas junto las probables
* `muertes_nuevas` = El número de nuevas muertes
* `positivas` = El total de pruebas confirmadas (PCR y rápidas)
* `positivas_pcr` = El total de pruebas PCR confirmadas
* `positivas_pcr_nuevas` = El número de nuevas pruebas PCR confirmadas
* `positivas_rapidas` = El total de pruebas rápidas confirmadas
* `negativas` = El total de pruebas descartadas (PCR y rápidas)
* `negativas_pcr` = El total de pruebas PCR descartadas
* `negativas_pcr_nuevas` = El número de nuevas pruebas PCR descartadas
* `negativas_rapidas` = El total de pruebas rápidas descartadas
* `defunciones` = El total acumulado de defunciones de este año
* `defunciones_nuevas` = El número total de defunciones del día
* `defunciones_2019` = El total acumulado de defunciones 2019
* `defunciones_2019_nuevas` = El número total de defunciones del día 
* `defunciones_2018` = El total acumulado de defunciones 2018
* `defunciones_2018_nuevas` = El número total de defunciones del día 
* `defunciones_2017` = El total acumulado de defunciones 2017
* `defunciones_2017_nuevas` = El número total de defunciones del día 
* `defunciones_2016` = El total acumulado de defunciones 2016
* `defunciones_2016_nuevas` = El número total de defunciones del día 
* `defunciones_2015` = El total acumulado de defunciones 2015
* `defunciones_2015_nuevas` = El número total de defunciones del día 
* `hospitalizadas_altas` = El total de alta hospitalitaria
* `hospitalizadas_estables` = El total de hospitalizados estables
* `hospitalizadas_pronostico_reservadas` = El total de hospitalizados con pronóstico reservado
* `created_at` = El día de registro de informe MSP


[ecuacovid-muertes_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid-muertes_por_dia.csv) (`informacion`, `fechas por día`) donde:

* `informacion` = Tipo de muerte (uertes, confirmadas, probables, nuevas)
* `fechas por día` = Todas las fechas por día

[ecuacovid-positivas_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid-positivas_por_dia.csv) (`informacion`, `fechas por día`) donde:

* `informacion` = Información del total calculado (total confirmados, PCR, nuevas PCR, y rápidas)
* `fechas por día` = todas las fechas por día

[muertes/provincias.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/provincias.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/provincias.json)] (`provincia`, `poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El total número de muertes
* `lat` = Latitud
* `lng` = Longitud
* `created_at` = La fecha del registro

[muertes/por_fecha/provincias_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/por_fecha/provincias_por_dia.csv) (`provincia`, `poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El total número de muertes
* `lat` = Latitud
* `lng` = Longitud
* `fechas por día` = todas las fechas por día

[defunciones/cantones.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/cantones.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/cantones.json)] (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud
* `lng` = Longitud
* `created_at` = La fecha del registro

[defunciones/provincias.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/provincias.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/provincias.json)] (`provincia`, `poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de defunciones
* `lat` = Latitud
* `lng` = Longitud
* `created_at` = La fecha del registro por día

[defunciones/por_fecha/provincias_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/por_fecha/provincias_por_dia.csv) (`provincia`, `poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de defunciones
* `lat` = Latitud
* `lng` = Longitud
* `fechas por día` = todas las fechas por día

[positivas/cantones.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/cantones.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/cantones.json)] (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud
* `lng` = Longitud
* `created_at` = La fecha del registro

[positivas/por_fecha/cantones_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/por_fecha/cantones_por_dia.csv): (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud
* `lng` = Longitud
* `fechas por día` = todas las fechas por día

[positivas/provincias.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/provincias.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/provincias.json)] (`provincia`, `poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud
* `lng` = Longitud
* `created_at` = La fecha del registro

[positivas/por_fecha/provincias_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/por_fecha/provincias_por_dia.csv) (`provincia`, `poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud
* `lng` = Longitud
* `fechas por día` = todas las fechas por día

## Instituto Nacional de Estadística y Censos (INEC)

Incluímos también los mismos datos con campos adicionales de INEC, son:

[muertes/provincias.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/provincias.inec.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/provincias.inec.json)] :
* `inec_provincia_id` = Código de referencia de la provincia

[muertes/por_fecha/provincias_por_dia.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/por_fecha/provincias_por_dia.inec.csv):
* `inec_provincia_id` = Código de referencia de la provincia

[defunciones/cantones.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/cantones.inec.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/cantones.inec.json)] :
* `inec_provincia_id` = Código de referencia de la provincia
* `inec_canton_id` = Código de referencia de cantón

[defunciones/por_fecha/cantones_por_dia.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/por_fecha/cantones_por_dia.inec.csv):
* `inec_provincia_id` = Código de referencia de la provincia
* `inec_canton_id` = Código de referencia de cantón

[defunciones/provincias.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/provincias.inec.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/provincias.inec.json)] :
* `inec_provincia_id` = Código de referencia de la provincia

[defunciones/por_fecha/provincias_por_dia.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/por_fecha/provincias_por_dia.inec.csv):
* `inec_provincia_id` = Código de referencia de la provincia

[positivas/cantones.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/cantones.inec.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/cantones.inec.json)]:
* `inec_provincia_id` = Código de referencia de la provincia
* `inec_canton_id` = Código de referencia de la provincia

[positivas/por_fecha/cantones_por_dia.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/por_fecha/cantones_por_dia.inec.csv):
* `inec_provincia_id` = Código de referencia de la provincia
* `inec_canton_id` = Código de referencia de cantón

[positivas/por_fecha/cantones_por_dia.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/por_fecha/cantones_por_dia.inec.csv): 
* `inec_provincia_id` = Código de referencia de la provincia
* `inec_canton_id` = Código de referencia de cantón

[positivas/provincias.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/provincias.inec.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/provincias.inec.json)]:
* `inec_provincia_id` = Código de referencia de la provincia

[positivas/por_fecha/provincias_por_dia.inec.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/provincias_por_fecha.inec.csv):
* `inec_provincia_id` = Código de referencia de la provincia

# ¿Por qué debo confiar en la precisión de estos datos?

Todos los datos están _tested_, [aquí puedes revisar](spec/ecuacovid/criterios.rb) con más detalle los criterios que verifica. Todas las pruebas automáticas verifica que nuestros datos extraídos sumen totales exactamente iguales a los reportados por el Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador.

Para ejectuar las pruebas en su maquina sigue las instrucciones [aquí](PRUEBAS.md).

# Licencia

MIT License

Copyright (c) 2020 Andrés N. Robalino, Andrab. <andres@androbtech.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.