/** @type {import('@sveltejs/kit').GetSession} */
export const getSession = (event) => {
  console.log('USER GETSESSION : ', event.locals.user);

  return event.locals.user
    ? {
        user: { ...event.locals.user }
      }
    : {};
};
