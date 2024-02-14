# Creació imatge Docker

Tenim un arxiu Dockerfile que conté els comands necessaris per crear una imatge Docker que permetrà executar el conegut joc 2048.

```language-bash
docker build -t calonso6/2048 .
```

Provem el nostre contenidor:

```language-bash
docker run -it --rm --name 2048 calonso6/2048
```

Un cop creada la imatge es pot publicar al repositori DockerHub o al que vulguem:

```language-bash
docker push calonso6/2048
```

També es pot indicar la *versió* afegint una etiqueta o *tag*:

```language-bash
docker tag calonso6/2048 calonso6/2048:v1.0
```

## Etiquetat: versionatge i latest

Si no s'indica cap etiqueta, Docker *etiqueta* la versió com *latest* i òbviamenet, només ens deixarà tenir una imatge associada al nom. Per etiquetar una imatge, farem servir la comanda `docker tag`:

```language-bash
docker tag calonso6/2048 calonso6/2048:v1.0
```

Amb això tindrem la mateixa imatge etiquetada amb `latest` i amb `v1.0`. Si ara volem pujar la imatge amb totes les etiquetes:

```language-bash
docker push -a calonso6/2048
```

L'ús d'etiquetes no només ens permet descriure d'una forma més clara la versió concreta de la imatge, sinó que a més podrem tenir diferents versions de la imatge al repositori.

## Construir imatges multiplataforma

Provat amb la versió 3.5.2 de Docker Desktop i la versió 20.10.7 de Docker Engine.

Per configurar `buildx`:

```bash
$ docker buildx create --name mbuilder
$ docker buildx use mbuilder
% docker buildx inspect --bootstrap                                                                        
Name:   mbuilder
Driver: docker-container

Nodes:
Name:      mbuilder0
Endpoint:  unix:///var/run/docker.sock
Status:    running
Platforms: linux/arm64, linux/amd64, linux/riscv64, linux/ppc64le,
linux/s390x, linux/386, linux/mips64le, linux/mips64, linux/arm/v7,
linux/arm/v6
```

Abans de construir la imatge ens hem de llogar a Docker Hub, perquèla imatge multiplataforma no s'emmagatzema en local, sinó que cal pujar-la al repositori.

```bash
    docker login -u calonso6
```

I ara ja podem crear una imatge capaç d'executar-se a la arquitectura `linux/amd64` i `linux/arm64`:

```bash
    docker buildx build --platform linux/amd64,linux/arm64 -t calonso6/2048:latest --push .
```

Amb aquesta ordre es construeix la imatge multiplataforma i es puja a Docker Hub.

## Executar la imatge en local

Com sempre, per executar la imatge, farem `docker run`.
Docker examinarà l'arquitectura de l'ordinador i descarregarà la imatge apropiada.

```bash
    docker run -dp 8000:80 caonso6/2048
```

Si estem en una màquina Intel baixarà la imatge `linux/amd64` i si estem en un MacBook M1 es baixarà la imatge `linux/arm64`.
