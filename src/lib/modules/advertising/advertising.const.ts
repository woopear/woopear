import type { IAdverting, IAdvertingArticle } from './advertising.type';

// notification pour la publicité
export const enum EAdvertisingNotif {
  ADD_SUCCES = 'votre publicité a bien été créé',
  ADD_ERROR = 'impossible de créer votre publicité, une erreur est survenue',

  UPDATE_SUCCES = 'votre publicité a bien été modifié',
  UPDATE_ERROR = 'impossible de modifier votre publicité, une erreur est survenue',

  DELETE_SUCCES = 'votre publicité a bien été supprimé',
  DELETE_ERROR = 'impossible de supprimer votre publicité, une erreur est survenue',
}

export const enum EAdvertisingSelectedNotif {
  UPDATE_SUCCES = '',
  UPDATE_ERROR = '',

  DELETE_SUCCES = '',
  DELETE_ERROR = '',
}

export const enum EAdvertisingArticleSelectedNotif {
  ADD_SUCCES = 'votre article de publicité a bien été créé',
  ADD_ERROR = 'impossible de créer votre article de publicité, une erreur est survenue',

  UPDATE_SUCCES = '',
  UPDATE_ERROR = '',

  DELETE_SUCCES = '',
  DELETE_ERROR = '',
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
