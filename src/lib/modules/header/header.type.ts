import type { IMenu } from '../menu/menu.type';

// interface du header
export interface IHeader {
  id?: string;
  brand?: string;
  menus?: IMenu;
}
