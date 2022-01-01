// il n'y a pas d'utiliter avec graphql, mais les interfaces sont prete au cas où
export interface IErrorPayload {
	statusCode?: number;
	error?: string;
	message?: string;
}
export interface IErrorOutPut {
	payload?: IErrorPayload;
}
export interface IErrorException {
	output?: IErrorOutPut;
}
export interface IErrorExtensions {
	exception?: IErrorException;
}
export interface IError {
	extensions?: IErrorExtensions;
}

export interface IErrorReceved {
	errors?: IError[];
}
