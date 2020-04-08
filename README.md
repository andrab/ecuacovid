[![Travis Build Status](https://travis-ci.org/andrab/ecuacovid.svg?branch=master)](https://travis-ci.org/andrab/ecuacovid)
[![Maintainability](https://api.codeclimate.com/v1/badges/2e4a49500559587cbc5f/maintainability)](https://codeclimate.com/github/andrab/ecuacovid/maintainability)
[![Discord](https://img.shields.io/discord/693754947040444436.svg?logo=discord)](https://discord.gg/WnS2ss)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/andrab/ecuacovid)


# Ecuacovid

Un proyecto que te proporciona un conjunto de datos sin procesar extraído [de los informes](fuentes/) de la situación nacional frente a la Emergencia Sanitaria por el COVID-19 del Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador ([SNGRE](https://www.gestionderiesgos.gob.ec)).

# Información

Por el momento se proporcionan los casos positivos y muertes en formatos csv y json. Puedes ver los archivos en la carpeta `datos_crudos` [aquí](datos_crudos/). Contienen los siguientes campos:

[muertes.csv](datos_crudos/muertes.csv) (`provincia`, `poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `poblacion` = La población total
* `total` = El total número de muertes
* `lat` = Latitud
* `lng` = Longitud
* `created_at` = La fecha del registro

[positivas.csv](datos_crudos/positivas.csv) (`provincia`, `provincia_poblacion`, `canton`, `canton_poblacion`, `total`, `lat`, `lng`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `provincia_poblacion` = La población total
* `canton` = El nombre del canton
* `canton_poblacion` = La población total
* `total` = El número de casos positivos
* `lat` = Latitud de cantón
* `lng` = Longitud de cantón
* `created_at` = La fecha del registro

## Instituto Nacional de Estadística y Censos (INEC)

Incluímos también los mismos datos con campos adicionales del INEC, son:

[muertes.inec.csv](datos_crudos/muertes.inec.csv):
* `inec_provincia_id` = Código de referencia de la provincia

[positivas.inec.csv](datos_crudos/positivas.inec.csv):
* `inec_provincia_id` = Código de referencia de la provincia
* `inec_canton_id` = Código de referencia de cantón

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
