# Description

# Dossier SVELTEKIT

> ce dossier contiendra la partie front du projet  
> il contient un fichier `.gitkeep` afin d'avoir le dossier disponible sur le repo  
> vous pourrez le supprimer après l'installation

# Dossier STRAPI

> Ce dossier contiendra l'application `strapi` qui nous servira d'`api`  
> Il contient un fichier `.gitkeep` afin d'avoir le dossier disponible sur le repo  
> vous pourrez le supprimer après l'installation du container `api`,  
> je vous suggere de laisser le `.gitignore` qui sera créé après l'installation  
> des containers car le `gitignore` à la racine ne couvre peut etre pas  
> les nouveauté de `strapi`

# Fichier DOCKER-COMPOSE

1. ## Description des services et modification au besoin de votre projet

- 1.1. Service `mysql`

  > ce service est le service de la base de données qui sera en Mysql  
  > vous pouvez modifier les données suivantes au besoin

  - `container_name` = donner un nom de container spécifique
  - `image` = image de la base de données, de base mysql:8.0 est définie
  - `networks` = nom du network pour la relation entre les containers
  - `volumes` = nom des volumes que vous voulez attribuer, de base il est défini mysql  
    (cela créera un dossier mysql qui permettra de faire persister les données)

- 1.2. Service `strapi`

  > ce service est le service de l'application `strapi`  
  > vous pouvez modifier les données suivantes au besoin

  - `container_name` = donner un nom de container spécifique
  - `ports` = les ports de votre application, définis sur 1337 de base
  - `networks` = nom du network pour la relation entre les containers
  - `volumes` = nom des volumes que vous voulez attribuer, ici sa sera le dossier strapi  
    (qui est deja créé)

- 1.3. Service `pma`

  > ce service est le service PHPMYSQL permet de gerer la bdd  
  > vous pouvez modifier les données suivantes au besoin

  - `container_name` = donner un nom de container spécifique
  - `ports` = les ports
  - `networks` = nom du network pour la relation entre les containers

> pour la connexion à phpmyadmin  
> soit utiliser l'utilisateur par defaut `root` + `le mot de passe dans MYSQL_ROOT_PASSWORD`  
> soit avec l'utilisateur `MYSQL_USER` + `MYSQL_PASSWORD`  
> l'utilisateur root vous donne plus de souplesse.

- 1.4. Service `sveltekit`

  > ce service est le service Sveltekit, contient tous votre front  
  > vous pouvez modifier les données suivantes au besoin

  - `container_name` = donner un nom de container spécifique
  - `image` = image de sveltekit, vous pouvez renomer cette image qui sera creer avec le dockerfile
  - `ports` = les ports de votre application, définis sur 3000 pour le front et 24680 pour le server vite
  - `networks` = nom du network pour la relation entre les containers
  - `volumes` = nom des volumes que vous voulez attribuer, 3 dossiers de volume sont deja définis  
    1 pour le projet complet  
    1 pour le dossier `node_modules`  
    1 pour le dossier `.svelte-kit`

**Le fichier docker-compose contient des commentaire  
pour vous aidez à faire vos modifications**

## Continuer vers les [erreurs possible](./erreur-possible.md)
