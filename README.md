[![Travis Build Status](https://travis-ci.org/andrab/ecuacovid.svg?branch=master)](https://travis-ci.org/andrab/ecuacovid)
[![Maintainability](https://api.codeclimate.com/v1/badges/2e4a49500559587cbc5f/maintainability)](https://codeclimate.com/github/andrab/ecuacovid/maintainability)
[![Discord](https://img.shields.io/discord/693754947040444436.svg?logo=discord)](https://discord.gg/WnS2ss)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/andrab/ecuacovid)


# Ecuacovid

Un proyecto que te proporciona un conjunto de datos sin procesar extraído [de los informes](fuentes/) de la situación nacional frente a la Emergencia Sanitaria por el COVID-19 del Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador ([SNGRE](https://www.gestionderiesgos.gob.ec)).

# Información

Por el momento se proporcionan los casos positivos y muertes en formatos (`.csv`, `.json`). Puedes ver los archivos en `datos_crudos` [[aquí](datos_crudos/)]. Contienen los siguientes campos:

Muertes (`provincia`, `total`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `total` = El total número de muertes
* `created_at` = La fecha del registro

Positivas (`provincia`, `canton`, `total`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `canton` = El nombre del canton
* `total` = El total número de casos positivos
* `created_at` = La fecha del registro

# Observaciones

No están publicando ni la provincia ni canton de las muertes (al principio lo hacían) por lo que se incluye para cada día un "dato" adicional que no tiene valor en `provincia` siendo `null` (csv: ` `, json: `null`) y su `total` es el número de muertes de _ese_ día. Revisar los días en [csv](datos_crudos/muertes.csv) y [json](datos/muertes.lindo.json)(versión pretty-json) para entender.


# ¿Por qué debo confiar en la precisión de estos datos?

Todos los datos están _tested_, [aquí puedes revisar](spec/ecuacovid/criterios.rb) con más detalle los criterios que verifica. Todas las pruebas automáticas verifica que nuestros datos extraídos sumen totales exactamente iguales a los reportados por el Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador.

Para ejectuar las pruebas en su maquina sigue las instrucciones [aquí](PRUEBAS.md).

# Licensia

Copyright (c) 2020 Andrés N. Robalino <andres@androbtech.com>

This program is free software. It comes without any warranty,
to the extent permitted by applicable law.
You can redistribute it and/or modify it under the terms of the
Do What The Fuck You Want To Public License,
Version 2, as published by Sam Hocevar.
See http://www.wtfpl.net/ for more details.
