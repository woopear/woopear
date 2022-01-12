import { gql } from 'graphql-request';

export const conditionGeneQuery = {
	/**
	 * request recuperer tout les conditionGene
	 */
	getAllCondition: gql`
		query getAllCondition {
			allConditionGeneVente(_size: 50) {
				data {
					_id
					activate
					articles {
						_id
						title
						subTitle
						content
						_ts
					}
					_ts
				}
			}
		}
	`,

	/**
	 * request recupere la conditionGene activé
	 */
	getConditionActivate: gql`
		query getConditionActivate {
			conditionGeneVenteByActivate(activate: true) {
				_id
				activate
				articles {
					_id
					title
					subTitle
					content
					_ts
				}
				_ts
			}
		}
	`,

	/**
	 * request creation d'une conditionGene
	 */
	createConditiongene: gql`
		mutation createConditiongene($newCondition: ConditionGeneVenteInput!) {
			createConditionGeneVente(data: $newCondition) {
				_id
				activate
				articles {
					_id
					title
					subTitle
					content
					_ts
				}
				_ts
			}
		}
	`,

	/**
	 * modification de la conditionGene
	 */
	updateConditiongene: gql`
		mutation updateConditiongene($id: ID!, $updateCondition: ConditionGeneVenteInput!) {
			updateConditionGeneVente(id: $id, data: $updateCondition) {
				_id
				activate
				articles {
					_id
					title
					subTitle
					content
					_ts
				}
				_ts
			}
		}
	`,

	/**
	 * request supression dune condtionGene
	 */
	deleteConditionGene: gql`
		mutation deleteConditionGene($id: ID!) {
			deleteConditionGeneVente(id: $id) {
				_id
				activate
				articles {
					_id
					title
					subTitle
					content
					_ts
				}
				_ts
			}
		}
	`
};
