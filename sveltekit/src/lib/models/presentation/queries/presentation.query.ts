import { gql } from 'graphql-request';

export const presentationQuery = {
	/**
	 * recupere presentation
	 */
	getPresentation: gql`
		query getPresentation {
			presentation {
				id
				title
				subTitle
				description
				image {
					id
					name
					alternativeText
					url
					formats
				}
				created_at
				updated_at
			}
		}
	`,

	updatePresentation: gql`
	mutation UpdatePresentation( $data: editPresentationInput){
		updatePresentation(input: {data: $data}){
			presentation{
				title
				subTitle
				description
			}
		} 
	}
	`

};
