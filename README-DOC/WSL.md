# Modification pour environement WSl

[Retour à l'accueil](../README.md)

> pour que le projet fonctionne sur un environement WSL  
> il faut configurer le fichier `sveltekit.config.js`

- Modification

> ajouter les lignes ci-dessous dans le fichier  
> en dessous de clef `target:`

```JS
vite: {
      server: {
        watch: {
          usePolling: true,
        },
        hmr: {
          port: 24680,
          clientPort: 3000,
        },
      },
    },
```
