/**
 * interface du product en détail
 */
export interface IProduct {
  id?: string;
  content?: string;
  url?: string;
  images?: [string];
  technos?: [string];
}

/**
 * interface de la partie product
 */
export interface IProductWoo {
  id?: string;
  title?: string;
  description?: string;
  image?: string;
  products?: [IProduct];
}
