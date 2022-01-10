interface IItemMenu {
	libelle: string;
	path: string;
}

export interface IItemMenuHeader {
	home?: IItemMenu;
	service?: IItemMenu;
	method?: IItemMenu;
	team?: IItemMenu;
	product?: IItemMenu;
	contact?: IItemMenu;
}

export interface IItemMenuDashboard {
	mentionlegales?: IItemMenu;
}
