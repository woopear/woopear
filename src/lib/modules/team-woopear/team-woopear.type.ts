/*
* interface producer de team woopear
*/
export interface IteamWoopearProducer{
  full_name?: string,
  job?: string,
  description?: string,
  image?: string
}

/* 
* interface team woopear
*/
export interface ITeamWoopear {
  id?: string,
  title?: string,
  description?: string,
  producer?: IteamWoopearProducer[]
}