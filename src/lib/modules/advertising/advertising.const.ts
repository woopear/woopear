import type { IAdverting } from './advertising.type';
// notification pour la publicité
export const enum EAdvertisingNotif {
  ADD_SUCCES = 'votre publicité a bien été créé',
  ADD_ERROR = 'impossible de créer votre publicité, une erreur est survenue',

  UPDATE_SUCCES = '',
  UPDATE_ERROR = '',

  DELETE_SUCCES = 'votre publicité a bien été supprimé',
  DELETE_ERROR = 'impossible de supprimer votre publicité, une erreur est survenue',
}


export const enum EAdvertisingSelectedNotif {
  ADD_SUCCES = '',
  ADD_ERROR = '',

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
