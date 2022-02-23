/*
 * interface companie du user
 */
export interface IUserCompanie {
  denomination?: string;
  siret?: string;
  code_naf?: string;
  address?: string;
  code_post?: string;
  city?: string;
  logo?: string;
}

/*
 * interface role du user
 */
export interface IUserRole {
  libelle?: string;
  description?: string;
}

/*
 * interface user
 */
export interface IUser {
  id?: string;
  first_name?: string;
  last_name?: string;
  user_name?: string;
  address?: string;
  code_post?: string;
  city?: string;
  phone_number?: string;
  avatar?: string;
  companie?: IUserCompanie;
  role?: IUserRole;
  uid?: string;
}
