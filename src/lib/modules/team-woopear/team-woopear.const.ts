import type { ITeam, ITeamProducer } from './team-woopear.type';

/**
 * enum team
 */
export const enum ETeamNotif {
  ADD_SUCCES = '',
  ADD_ERROR = 'Impossible de créer une équipe',

  UPDATE_SUCCES = 'Equipe modifiée avec succès',
  UPDATE_ERROR = "Impossible de modifer l'équipe",

  DELETE_SUCCES = '',
  DELETE_ERROR = "Impossible de supprimer l'équipe"
}

/**
 * enum team selected
 */
export const enum ETeamSelectedNotif {
  UPDATE_SUCCES = 'Equipe modifiée avec succès',
  UPDATE_ERROR = "Impossible de modifer l'équipe"
}

/**
 * enum team producer
 */
export const enum ETeamProducerNotif {
  ADD_SUCCES = '',
  ADD_ERROR = 'Impossible de créer une personne',

  DELETE_SUCCES = '',
  DELETE_ERROR = 'Impossible de supprimer la personne'
}

/**
 * enum team selected producer
 */
export const enum ETeamSelectedProducerNotif {
  UPDATE_SUCCES = 'La personne à été modifiée avec succès',
  UPDATE_ERROR = 'Impossible de modifer la personne'
}

/**
 * creation d'une team
 * @returns retourne une team
 */
export function createTeam(): ITeam {
  return {
    active: false,
    description: '',
    title: ''
  };
}

/**
 * creation d'une personne d'une team
 * @returns retourne une personne d'un team
 */
export function createTeamProducer(): ITeamProducer {
  return {
    description: '',
    full_name: '',
    job: '',
    image: ''
  };
}
