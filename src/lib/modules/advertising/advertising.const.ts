import type { IAdverting, IAdvertingArticle, IAdvertingArticleContent } from './advertising.type';

// notification pour la publicité
export const enum EAdvertisingNotif {
  ADD_SUCCES = 'votre publicité a bien été créé',
  ADD_ERROR = 'impossible de créer votre publicité, une erreur est survenue',

  UPDATE_SUCCES = 'votre publicité a bien été modifié',
  UPDATE_ERROR = 'impossible de modifier votre publicité, une erreur est survenue',

  UPLOAD_IMAGE_SUCCES = 'votre image publicité a bien été ajouter',
  UPLOAD_IMAGE_ERROR = "impossible d'ajouter votre image publicité, une erreur est survenue",

  DELIMAGE_SUCCES = 'votre image publicité a bien été supprimé',
  DELIMAGE_ERROR = "impossible de supprimer votre image publicité, une erreur est survenue",

  DELETE_SUCCES = 'votre publicité a bien été supprimé',
  DELETE_ERROR = 'impossible de supprimer votre publicité, une erreur est survenue',
}

export const enum EAdvertisingArticleSelectedNotif {
  ADD_SUCCES = 'votre article de publicité a bien été créé',
  ADD_ERROR = 'impossible de créer votre article de publicité, une erreur est survenue',

  UPDATE_SUCCES = 'votre article de publicité a bien été modifié',
  UPDATE_ERROR = 'impossible de modifier votre publicité, une erreur est survenue',

  UPLOAD_IMAGE_SUCCES = "votre image de l'article publicité a bien été ajouter",
  UPLOAD_IMAGE_ERROR = "impossible d'ajouter votre image de l'article publicité, une erreur est survenue",

  DELIMAGE_SUCCES = "votre image de l'article publicité a bien été supprimé",
  DELIMAGE_ERROR = "impossible de supprimer votre image de l'article publicité, une erreur est survenue",

  DELETE_SUCCES = 'votre article de publicité a bien été supprimer',
  DELETE_ERROR = 'impossible de supprimer votre article de publicité, une erreur est survenue',
}

export const enum EAdvertisingArticleSelectedContentNotif {
  ADD_SUCCES = "votre content de l'article de publicité a bien été créé",
  ADD_ERROR = "impossible de créer votre content de l'article de publicité, une erreur est survenue",

  UPDATE_SUCCES = "votre content de l'article de publicité a bien été modifié",
  UPDATE_ERROR = "impossible de créer votre content de l'article de publicité, une erreur est survenue",

  DELETE_SUCCES = "votre content de l'article de publicité a bien été supprimer",
  DELETE_ERROR = "impossible de supprimer votre content de l'article de publicité, une erreur est survenue",
}

export function createAdvertisingObject(): IAdverting {
  return {
    active: false,
          image: '',
          label: {
            description: '',
            libelle: ''
          },
          title:''
  }
}

export function createAdvertisingArticleObject(): IAdvertingArticle {
  return {
    active: false,
          image: '',
          content: [],
          title:''
  }
}

export function createContentAdvertisingArticleObject(): IAdvertingArticleContent {
  return {
    sub_title:'',
    text:''
  }
}
