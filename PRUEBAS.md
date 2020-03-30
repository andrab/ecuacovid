# Ejecución de las pruebas

Empieza instalando las dependencias.

``` sh
git clone https://github.com/andrab/ecuacovid
cd ecuacovid
bundle
bundle exec rake
```

## Requerimientos

### Nushell

Vas a necesitar [Nushell](https://nushell.sh). Puedes descargar binarios de `Nu` para tu sistema operativo en [la página de releases](https://github.com/nushell/nushell/releases). Una vez instalado `Nu`, asegúrate de que se encuentre en la variable de entorno `PATH`.

También puedes instalar `Nu` con `Docker` y otras maneras siguiendo [estas instrucciones](https://www.nushell.sh/book/es/instalacion.html).

## Ruby

Si el comando `bundle` falla, puede que necesites actualizar la versión de Ruby. Puedes usar [RVM](https://rvm.io/) para instalarlo:

``` sh
curl -L https://get.rvm.io | bash -s stable
rvm install $(cat .ruby-version)
rvm use $(cat .ruby-version)
rvm gemset use $(cat .ruby-gemeset)
```
