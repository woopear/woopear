/*
 * interface producer de team woopear
 */
export interface ITeamProducer {
  id?: string;
  full_name?: string;
  job?: string;
  description?: string;
  image?: string;
}

/*
 * interface team woopear
 */
export interface ITeam {
  id?: string;
  title?: string;
  description?: string;
  producer?: ITeamProducer[];
  active?: boolean;
}
