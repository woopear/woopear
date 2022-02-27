import type { IProduct, IWebapp } from './webapp.type';

// message de notif webapp
export const enum EWebappNotif {
  ADD_SUCCES = '',
  ADD_ERROR = 'Impossible de créer le webapp',

  UPDATE_SUCCES = '',
  UPDATE_ERROR = 'Impossible de modifier le webapp',

  DELETE_SUCCES = '',
  DELETE_ERROR = 'Impossible de supprimer le webapp',

  DELIMAGE_SUCCES = '',
  DELIMAGE_ERROR = "Impossible de supprimer l'image du webapp"
}

// message notif webapp selected
export const enum EWebappSelectedNotif {
  ADD_SUCCES = '',
  ADD_ERROR = 'Impossible de créer le webapp',

  UPDATE_SUCCES = 'Le web app à été mise à jour',
  UPDATE_ERROR = 'Impossible de modifier le webapp',

  UPLOAD_IMAGE_SUCCES = 'Image téléchargée avec succès',
  UPLOAD_IMAGE_ERROR = "Impossible de télécharger l'image du webapp",

  DELETE_SUCCES = '',
  DELETE_ERROR = 'Impossible de supprimer le webapp',

  DELIMAGE_SUCCES = 'Image supprimée avec succès',
  DELIMAGE_ERROR = "Impossible de supprimer l'image du webapp"
}

// message notif webapp product
export const enum EWebappProductNotif {
  ADD_SUCCES = 'Le nouveau site est disponible',
  ADD_ERROR = 'Impossible de créer le site du web app',

  UPDATE_SUCCES = 'Modification du site réussi',
  UPDATE_ERROR = 'Impossible de modifier le site du web app',

  UPDATE_TAB_SUCCES = '',
  UPDATE_TAB_ERROR = 'Une erreur est survenu pendant la modification ou la création',

  UPLOAD_IMAGE_SUCCES = 'Image téléchargée avec succès',
  UPLOAD_IMAGE_ERROR = "Impossible de télécharger l'image",

  DELETE_SUCCES = 'Le site a bien été supprimé',
  DELETE_ERROR = 'Impossible de supprimer le site',

  DELIMAGE_SUCCES = 'Image supprimée avec succès',
  DELIMAGE_ERROR = "Impossible de supprimer l'image"
}

// creation de l'objet webapp
export function createWebapp(): IWebapp {
  return {
    active: false,
    description: '',
    image: '',
    title: ''
  };
}

// creation de l'objet webapp product
export function createWebappProduct(): IProduct {
  return {
    content: '',
    title: '',
    url: '',
    images: [],
    technos: []
  };
}
