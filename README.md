[![Travis Build Status](https://travis-ci.org/andrab/ecuacovid.svg?branch=master)](https://travis-ci.org/andrab/ecuacovid)
[![Maintainability](https://api.codeclimate.com/v1/badges/2e4a49500559587cbc5f/maintainability)](https://codeclimate.com/github/andrab/ecuacovid/maintainability)
[![Discord](https://img.shields.io/discord/693754947040444436.svg?logo=discord)](https://discord.gg/WnS2ss)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/andrab/ecuacovid)


# Ecuacovid

Un proyecto que te proporciona un conjunto de datos sin procesar extraído [de los informes](informes/) de la situación nacional frente a la Emergencia Sanitaria por el COVID-19 del Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador (SNGRE), Ministerio de Salud Pública del Ecuador (MSP), y Registro Civil del Ecuador.

# Información

Por el momento se proporcionan los casos positivos, muertes, muertes probables, y defunciones en formatos csv y json. Puedes ver los archivos en la carpeta `datos_crudos` [aquí](datos_crudos/). Contienen lo siguiente:

[ecuacovid.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid.json)] (`muertes`, `muertes_probables`, `total_muertes`, `positivas`, `negativas`, `created_at`) donde:

* `muertes` = El total de muertes
* `muertes_probables` = El total de muertes probables
* `total_muertes` = El total de muertes más el total de las muertes probables
* `positivas` = El total de casos positivos
* `negativas` = El total de casos negativos
* `created_at` = La fecha del registro **hasta 7 de Mayo**

[ecuacovid-muertes_por_fecha.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid-muertes_por_fecha.csv) (`pais`, `fechas por día`) donde:

* `pais` = Ecuador
* `fechas por día` = todas las fechas por día **hasta 7 de Mayo**

[ecuacovid-con-muertes-probables_por_fecha.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid-con-muertes-probables_por_fecha.csv) (`pais`, `fechas por día`) donde:

* `pais` = Ecuador
* `fechas por día` = todas las fechas por día **hasta 7 de Mayo**

[ecuacovid-positivas_por_fecha.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/ecuacovid-positivas_por_fecha.csv) (`pais`, `fechas por día`) donde:

* `pais` = Ecuador
* `fechas por día` = todas las fechas por día **hasta 7 de Mayo**

[muertes/provincias.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/provincias.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/provincias.json)] (`provincia`, `poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El total número de muertes
* `lat` = Latitud
* `lng` = Longitud
* `created_at` = La fecha del registro **hasta 7 de Mayo**

[muertes/por_fecha/provincias_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/muertes/por_fecha/provincias_por_dia.csv) (`provincia`, `poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El total número de muertes
* `lat` = Latitud
* `lng` = Longitud
* `fechas por día` = todas las fechas por día **hasta 7 de Mayo**

[defunciones/cantones.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/cantones.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/cantones.json)] (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de defunciones
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `created_at` = La fecha del registro **hasta 5 de Mayo**

[defunciones/por_fecha/cantones_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/por_fecha/cantones_por_dia.csv) (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de defunciones
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `fechas por día` = todas las fechas por día **hasta 5 de Mayo**

[defunciones/provincias.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/provincias.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/provincias.json)] (`provincia`, `poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de defunciones
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `created_at` = La fecha del registro por día **hasta 5 de Mayo**

[defunciones/por_fecha/provincias_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/defunciones/por_fecha/provincias_por_dia.csv) (`provincia`, `poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de defunciones
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `fechas por día` = todas las fechas por día **hasta 5 de Mayo**

[positivas/cantones.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/cantones.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/cantones.json)] (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `created_at` = La fecha del registro **hasta 5 de Mayo** 

[positivas/por_fecha/cantones_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/por_fecha/cantones_por_dia.csv): (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `fechas por día` = todas las fechas por día **hasta 5 de Mayo**

[positivas/provincias.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/provincias.csv) [[json](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/provincias.json)] (`provincia`, `poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `created_at` = La fecha del registro **hasta 5 de Mayo**

[positivas/por_fecha/provincias_por_dia.csv](https://raw.githubusercontent.com/andrab/ecuacovid/master/datos_crudos/positivas/por_fecha/provincias_por_dia.csv) (`provincia`, `poblacion`, `total`, `lat`, `lng`, `fechas por día`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `fechas por día` = todas las fechas por día **hasta 5 de Mayo**

## Instituto Nacional de Estadística y Censos (INEC)

Incluímos también los mismos datos con campos adicionales del INEC, son:

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

Copyright (c) 2020 Andrés N. Robalino <andres@androbtech.com>

This program is free software. It comes without any warranty,
to the extent permitted by applicable law.
You can redistribute it and/or modify it under the terms of the
Do What The Fuck You Want To Public License,
Version 2, as published by Sam Hocevar.
See http://www.wtfpl.net/ for more details.
