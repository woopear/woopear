// interface des links des menus
export interface ILink {
  id?: string;
  libelle?: string;
  url?: string;
}

// interface menu
export interface IMenu {
  id?: string;
  libelle?: string;
  links?: [ILink];
}
