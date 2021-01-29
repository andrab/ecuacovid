[![Travis Build Status](https://travis-ci.org/andrab/ecuacovid.svg?branch=master)](https://travis-ci.org/andrab/ecuacovid)
[![Maintainability](https://api.codeclimate.com/v1/badges/2e4a49500559587cbc5f/maintainability)](https://codeclimate.com/github/andrab/ecuacovid/maintainability)
[![Discord](https://img.shields.io/discord/693754947040444436.svg?logo=discord)](https://discord.gg/WnS2ss)
[![@cocoronata](https://img.shields.io/badge/twitter-@cocoronata-1DA1F3?style=flat-square)](https://twitter.com/cocoronata)
[![@andras_io](https://img.shields.io/badge/twitter-@andras_io-1DA1F3?style=flat-square)](https://twitter.com/andras_io)

# Ecuacovid

Un proyecto que proporciona un conjunto de datos sin procesar extraído [de los informes](informes/) de la situación nacional frente a la Emergencia Sanitaria por el COVID-19 del Servicio Nacional de Gestión de Riesgos y Emergencias del Ecuador (SNGRE), Ministerio de Salud Pública del Ecuador (MSP), y Registro Civil del Ecuador.

# Información

Puedes ver los archivos crudos en distintas presentaciones en la carpeta `datos_crudos` [aquí](datos_crudos/).

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
SOFTWARE
