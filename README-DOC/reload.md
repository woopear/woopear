# Rechargement en continue

> Si après installation des containers et execution du projet  
> dans localhost, la page ce recharge en continue ajouter  
> les lignes ci-dessous

- Fichier svelte.config.js

  > ajouter ces lignes en dessous de la clef `target:` du fichier svelte.config.js

  ```js
  vite: {
      server: {
        hmr: {
          port: 24680,
        },
      },
    },
  ```

  > Attention ici le port 24680 correspond au port spécifié dans le service front  
  > et dans le dockerfile, si vous avez d'autre port de défini changez la valeur  
  > avec votre propre valeur.
