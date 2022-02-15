<script lang="ts">
  import { fire_auth } from '$lib/providers/firebase/firebase.service';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { signInWithEmailAndPassword } from 'firebase/auth';
  import type { IConnexion } from '../connexion.type';

  /**
   * connexion user
   * @param e => event du formulaire
   */
  const connect = async (e) => {
    try {
      const data = createObjectAsFormData<IConnexion>(e.target);
      const user = await fetch('api/connexion.json', {
        method: 'POST',
        body: JSON.stringify(data)
      });
      console.log(user);

      if (!user.ok) throw new Error('error');

      //$session.user = await user.json();
    } catch (error) {
      console.error(error);
    }
  };
</script>

<!-- connexion user simple (email, pwd) -->
<section>
  <form on:submit|preventDefault={connect}>
    <!-- email -->
    <div>
      <input name="email" class="input input-primary" placeholder="email" />
    </div>
    <!-- pwd -->
    <div class="mt-4 mb-8">
      <input name="password" class="input input-primary" placeholder="mot de passe" />
    </div>
    <!-- btn connect -->
    <button class="btn btn-primary">Connexion</button>
  </form>
</section>
