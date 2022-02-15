import type { IMenu } from '../menu/menu.type';
import type { IWoopear } from '../woopear/woopear.type';

// interface principal footer
export interface IFooter {
  id?: string;
  brand?: string;
  copyright?: string;
  woopear?: IWoopear;
  menus?: IMenu;
}
