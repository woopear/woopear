import { graphqlService } from '$lib/models/graphql/graphql.service';
import { connexionQuery } from '../queries/connexion.query';
import type { IConnextionObject, ILoginReceved } from '../types/connexion.type';
import { connexionMutation } from './connexion.mutation';

export const connexionApi = {
	/**
	 * connexion user recupere le login
	 */
	login: async (data: IConnextionObject): Promise<void> => {
		try {
			const res = await graphqlService.request<ILoginReceved>(connexionQuery.login, data);
			connexionMutation.setCurrentLogin(res.login);
		} catch (error) {
			throw new Error('Veuillez renseigner des identifiants valide !');
		}
	}
};
