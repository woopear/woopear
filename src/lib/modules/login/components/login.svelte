<script lang="ts">
  import { goto } from '$app/navigation';
  import { session } from '$app/stores';
  import Card from '$lib/modules/components/card/card.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { fire_auth } from '$lib/providers/firebase/firebase.service';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { signInWithEmailAndPassword } from 'firebase/auth';
  import type { ILogin } from '../login.type';

  /**
   * connexion simple utilisateur + affectation de session.user
   * @param e
   */
  const login = async (e) => {
    try {
      // creation des datas
      const data = createObjectAsFormData<ILogin>(e.target);
      // connexion firebase
      const user = await signInWithEmailAndPassword(fire_auth, data.email, data.password);
      // affectation au session.user la réponse reçus
      $session.user = user.user;
      // va sur la page dashboard
      goto('/dashboard');
    } catch (error) {
      // TODO : gerer les erreurs
      console.error(error);
    }
  };
</script>

<Card>
  <div class="m-auto mt-12 mb-8 text-center">
    <Title title="Connexion Woopear" type_title={ETypeTitle.H4} />
  </div>
  <form on:submit|preventDefault={login}>
    <div>
      <Input name="email" placeholder="Email" />
    </div>
    <div>
      <Input name="password" placeholder="mot de passe" />
    </div>
    <div class="flex justify-center mt-12">
      <button class="btn btn-primary">Se connecter</button>
    </div>
  </form>
</Card>
