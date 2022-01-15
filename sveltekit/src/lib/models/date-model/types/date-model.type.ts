/**
 * interface permettant d'etandre les autre avec les date de la bdd
 */
export interface IDateModel {
	created_at?: Date;
	updated_at?: Date;
}

/**
 * interface date pour faunadb
 */
export interface IDateFauna {
	_ts?: Date;
}
