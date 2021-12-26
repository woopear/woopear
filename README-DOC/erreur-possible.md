# Erreur non bloquant

1. - si vous rencontrez une erreur sur le front au moment du pulling  
     cela est normal, le front ne pull pas d'image docker,  
     car nous la créons avec le dockerfile

2. - erreur si votre demon docker redémarre apres une mise en veille  
     erreur possible : `error getting credentials - err: exit status 255, out`  
     vous devez redémarrer votre docker engine,  
     puis relancer la commande `docker-compose up`

3. - à la creation de votre premier content-type  
     dans strapi, vous recevrez peut etre une erreur  
     au moment de la sauvgarde. Ce bug n'est pas encore traité  
     mais il est non bloquant.  
     recharger votre page et vous verrez votre contenu mis à jour.  
     si le probleme persite, redémarrer les containers

**Si vous rencontrez des bugs autres que ceux mentionné ici**  
**ouvrez une issus et décrivez le bug, nous nous efforcerons**  
**de le regler au plus vite.**

## Continuez vers [l'installation des containers docker](./docker.md)
