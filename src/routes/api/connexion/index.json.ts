import { fire_auth } from '$lib/providers/firebase/firebase.service';
import { signInWithEmailAndPassword } from 'firebase/auth';

export const post = async ({ request }) => {
  try {
    const body = await request.json();

    const user = await signInWithEmailAndPassword(fire_auth, body.email, body.password);

    return {
      status: 200,
      body: {
        user
      }
    };
  } catch (error) {
    return {
      status: 500,
      body: {
        error: 'Connexion utilisateur, une erreur est survenue'
      }
    };
  }
};
