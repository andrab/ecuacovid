# Contribuciones

!Bienvenido a Ecuacovid!

Si ya dispones tanto de una copia del repo en tu cuenta personal de Github, una copia en tu máquina, y configurado dos remotes que apunten a las mismas, entonces no es necesario hacer estos pasos y puedes leer [realizar una contribución](#realizar-una-contribucion).

En caso de no tenerlo, para empezar debes hacer lo siguientes pasos:

1. Una copia -[fork](#hacer-un-fork)- del repo a tu cuenta personal de Github.
2. Una [copia del repo](#clona-el-repositorio-a-tu-máquina) en tu máquina.
3. Dos -[remotes](#apuntadores-con-remotes) Uno apuntando al repo oficial y el otro apuntando al repo de tu cuenta personal.

### Hacer un fork.

En la parte superior de la derecha, puedes hacer click donde dice `fork` y Github se encargará de clonarlo a tu cuenta personal.

### Clona el repositorio a tu máquina.

En la shell de preferencia debes clonarlo:

```sh
git clone https://github.com/andrab/ecuacovid.git
```

Debe aparecer algo similar a lo siguiente luego de ejecutar el comando y también una nueva carpeta creada con el mismo nombre `ecuacovid`:

```sh
> git clone https://github.com/andrab/ecuacovid.git
Cloning into 'ecuacovid'...
remote: Enumerating objects: 58068, done.
remote: Counting objects: 100% (5607/5607), done.
remote: Compressing objects: 100% (906/906), done.
remote: Total 58068 (delta 4725), reused 5505 (delta 4666), pack-reused 52461 eceiving objects: 100% (58
Receiving objects: 100% (58068/58068), 1.24 GiB | 1.74 MiB/s, done.
Resolving deltas: 100% (43565/43565), done.
Updating files: 100% (1712/1712), done.
```

### Apuntadores con remotes.

Si no estás todavía en la carpeta del repo, ve a la carpeta:

```sh
> cd ecuacovid
C:\Users\winandras\Code\ecuacovid(master)>
```

Primero revisa los apuntadores configurados en el repo clonado en tu máquina:

```sh
> git remote -v
origin  https://github.com/andrab/ecuacovid.git (fetch)
origin  https://github.com/andrab/ecuacovid.git (push)
```

Debido a que el resultado anterior se trata de un repo clonado directamente de la fuente oficial `https://github.com/andrab/ecuacovid.git`, aparecerá un solo remote (para operaciones -fetch- y -push-) llamado `origin` ambos apuntando a esa dirección.

Necesitamos *dos remotes* para operaciones de -fetch- y -push-, idealmente con nombres `origin` y `upstream` donde:

1. `origin` apunta a la direccion de tu repo personal en Github.
2. `upstream` apunta a la direccion del repo oficial.

Normalmente el remote `origin` debe apuntar a la dirección donde se encuentra el -fork- del repo de tu cuenta Github personal y en este caso no es así (claramente podemos observar que `origin` está apuntando a `https://github.com/andrab/ecuacovid.git`).

Sin embargo, es esa dirección `https://github.com/andrab/ecuacovid.git` la que nos interesa que el remote `upstream` apunte a ella. Lo que haremos para resolver el problema es usar el comando `git remote rename` para cambiar el nombre del remote `origin` a `upstream`:

```sh
> git remote rename origin upstream
```

Luego de hacerlo, verifiquemos nuevamente los remotes definidos:

```sh
> git remote -v
upstream        https://github.com/andrab/ecuacovid.git (fetch)
upstream        https://github.com/andrab/ecuacovid.git (push)
```

En efecto, lo hicimos correctamente pues podemos observar que solo hay un remote llamado `upstream` apuntando a `https://github.com/andrab/ecuacovid.git`

Ahora necesitamos agregar el remote `origin` y que apunte a la dirección donde se encuentra el fork (en tu cuenta personal). Por ejemplo, el fork del repo oficial en mi [cuenta personal](https://github.com/andrasio/ecuacovid) la dirección es `https://github.com/andrasio/ecuacovid.git`. Por lo que para agregar el remote `origin` con esa dirección usamos el comando `git remote add` pasando el nombre del remote y la dirección a la que apuntará:

```sh
> git remote add origin https://github.com/andrasio/ecuacovid.git
```

Verificando los remotes definidos nuevamente:

```sh
> git remote -v
origin  https://github.com/andrasio/ecuacovid.git (fetch)
origin  https://github.com/andrasio/ecuacovid.git (push)
upstream        https://github.com/andrab/ecuacovid.git (fetch)
upstream        https://github.com/andrab/ecuacovid.git (push)
```

!Estamos listos!

## Realizar una contribución.

Para realizar una contribución debes ir al repo:

```sh
> cd ecuacovid
```

Antes de hacer cambios para enviarlos a la fuente oficial como contribución siempre es bueno asegurarte de tener los `commits` al día. Para hacerlo, siempre necesitaremos -bajar- esos commits de la fuente oficial. Ecuacovid solo tiene una rama de trabajo llamada `master` y para bajar esos commits a nuestro repo de la máquina necesitamos hacerlo con el remote `upstream` de la siguiente manera (usando el comando `git pull`):

```sh
> git pull upstream master
```

Una vez que hacemos eso, procedemos a crear una nueva rama de trabajo en nuestra repo de la máquina para registrar nuestros commits de manera aislada y no en `master`. Haremos el ejercicio de agregar datos al repo, se desea para este ejemplo agregar información de vacunas diarias. Realizamos los siguientes pasos:

1. Bajar los commits de la fuente oficial.
2. Crear una rama de trabajo y ponerle un nombre al hacerlo.
3. Modificar/Agregar datos.
4. Registrar los archivos cambiados al arbol de índice de trabajo.
5. Realizar el commit con un mensaje en la rama de trabajo creada.
6. Enviar los commits de la rama de trabajo a la dirección del repo de tu cuenta de Github (`origin`)

