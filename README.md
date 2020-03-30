[![Travis Build Status](https://travis-ci.org/andrab/ecuacovid.svg?branch=master)](https://travis-ci.org/andrab/ecuacovid)
[![Maintainability](https://api.codeclimate.com/v1/badges/2c1e8fb845a904141619/maintainability)](https://codeclimate.com/github/andrab/ecuacovid/maintainability)
[![Discord](https://img.shields.io/discord/693754947040444436.svg?logo=discord)](https://discord.gg/WnS2ss)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/andrab/ecuacovid)


# Ecuacovid

Un proyecto que te proporciona los datos sin procesar, extraído de [los informes](fuentes/) del Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador ([SNGRE](https://www.gestionderiesgos.gob.ec)).

# Información

Por el momento se proporcionan los casos positivos y muertes en formatos (`.csv`, `.json`). Puedes [descargarlos aquí](datos_crudos/). Contienen los siguientes campos:

Muertes (`provincia`, `total`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `total` = El total número de muertes
* `created_at` = La fecha del registro

Positivas (`provincia`, `canton`, `total`, `created_at`) donde:

* `provincia` = El nombre de la provincia
* `canton` = El nombre del canton
* `total` = El total número de casos positivos
* `created_at` = La fecha del registro

# Licensia

Copyright (c) 2020 Andrés N. Robalino <andres@androbtech.com>

This program is free software. It comes without any warranty,
to the extent permitted by applicable law.
You can redistribute it and/or modify it under the terms of the
Do What The Fuck You Want To Public License,
Version 2, as published by Sam Hocevar.
See http://www.wtfpl.net/ for more details.
