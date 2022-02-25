/**
 * interface du product en détail
 */
export interface IProduct {
  id?: string;
  title?: string;
  content?: string;
  url?: string;
  images?: string[];
  technos?: string[];
  listtechnos?: string;
}

/**
 * interface de la partie product
 */
export interface IWebapp {
  id?: string;
  title?: string;
  description?: string;
  image?: string;
  active?: boolean;
  products?: [IProduct];
}
