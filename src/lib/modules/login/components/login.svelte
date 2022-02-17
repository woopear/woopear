<script lang="ts">
  import { goto } from '$app/navigation';
  import { session } from '$app/stores';
  import { fire_auth } from '$lib/providers/firebase/firebase.service';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { signInWithEmailAndPassword } from 'firebase/auth';
  import type { ILogin } from '../login.type';

  const login = async (e) => {
    try {
      // creation des datas
      const data = createObjectAsFormData<ILogin>(e.target);
      // connexion firebase
      const user = await signInWithEmailAndPassword(fire_auth, data.email, data.password);
      // affectation au stuff.user la réponse reçus
      $session.user = user.user;
      goto('/dashboard');
    } catch (error) {
      console.error(error);
    }
  };
</script>

<section>
  <a href="/" class="block mb-12">Retourne accueil</a>

  <form on:submit|preventDefault={login}>
    <div>
      <input name="email" placeholder="email" />
    </div>
    <div>
      <input name="password" placeholder="mot de passe" />
    </div>
    <button>Se connecter</button>
  </form>
</section>
