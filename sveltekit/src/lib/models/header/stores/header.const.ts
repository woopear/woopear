import type { IItemMenuDashboard, IItemMenuHeader } from '../types/header.type';

/**
 * const pour item menu principal
 */
export const constItemMenuHeader: IItemMenuHeader = {
	home: {
		libelle: 'Accueil',
		path: '#woopear'
	},
	service: {
		libelle: 'services',
		path: '#service'
	},
	method: {
		libelle: 'methode',
		path: '#methode'
	},
	team: {
		libelle: 'équipe',
		path: '#equipe'
	},
	product: {
		libelle: 'réalisation',
		path: '#realisation'
	},
	contact: {
		libelle: 'contact',
		path: '#contact'
	}
};

/**
 * const pour item menu dashboard
 */
export const constItemMenuDashbord: IItemMenuDashboard = {
	mentionlegales: {
		libelle: 'Mentions légales',
		path: '/dashboard/mentions-legales'
	}
};
