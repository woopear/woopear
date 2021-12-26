# Variable d'environement

[Retour à l'accueil](../README.md)

> Nous pouvons rajouter des variables d'environement à notre partie front  
> **ATTENION** creer un fichier .env à la racine du dossier front  
> sinon le server **vite** retournera une erreur au lancement du projet

- Creation du fichier `.env`

> dans le dossier front copier / coller le fichier `.env.exemple`  
> au meme endroit que celui-ci et renommer le en `.env`

- Installation package

```shell
// placez vous dans le dossier front
// puis executer la commande suivante
$ npm i -D env-cmd
```

- Modification du fichier package.json

> ajouter / modifier les lignes ci-dessous

```json
"scripts": {
    ...
    "dev": "env-cmd svelte-kit dev",
    ...
}
```
