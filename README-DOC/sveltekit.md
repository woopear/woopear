# Installation sveltekit

> installation d'un projet sveltekit  
> ouvrez un terminal à la racine de ce projet  
> puis executer les commandes suivantes

1. Entrer dans le dossier `sveltekit` déja créé

```shell
$ cd sveltekit/
```

2. Installation

```shell
$ npm init svelte@next .
```

<span style="color: #0070FF;">Le " . " indique le path d'installation
ici on lui dis d'installer dans le dossier courant (sveltekit)<span>

3. CLI d'installation

> le CLI va vous demander si vous voulez installer  
> dans un dossier non vide à cause du fichier `.gitkeep`  
> tapez (y) et continuer les instructions  
> pour les instructions suivante c'est à vous de voir

4. Installation des dépendences

```shell
$ npm i
```

5. Lancer le projet afin de creer le dossier `.svelte-kit`

```shell
$ npm run dev
```

6. Couper le server

```
taper `ctrl + c` dans votre terminal
```

7. Modifier le fichier svelte.config.js
   > ajouter la clef `vite`

```js
target: '#svelte',
vite: {
        hmr: {
          port: 24680,
        },
      },
```

8. Supression des fichiers (facultatif)

> supprimer les fichiers '.gitignore' et '.gitkeep'  
> vous n avez pas besoin de ses fichiers

```shell
$ rm -rf .gitignore .gitkeep
```

9. Fin d'installation sortez du dossier `sveltekit/`

```shell
$ cd ..
```

**après cette série d'instructions votre projet sveltekit est prêt.**

## Passer à [la description / modification des dossiers et fichiers](./docker-description.md)
