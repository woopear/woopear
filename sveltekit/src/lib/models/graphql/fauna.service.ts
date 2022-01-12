import faunadb from 'faunadb';

export const guestClient = new faunadb.Client({
	secret: import.meta.env.VITE_SECRET_PUBLIC_FAUNA
});

export const authClient = (secret: string): faunadb.Client => {
	return new faunadb.Client({
		secret
	});
};
