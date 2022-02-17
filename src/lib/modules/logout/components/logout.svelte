<script lang="ts">
  import { goto } from '$app/navigation';
  import { session } from '$app/stores';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { fire_auth } from '$lib/providers/firebase/firebase.service';
  import { signOut } from 'firebase/auth';

  /**
   * deconnexion simple utilisateur
   */
  const deconnect = async () => {
    // on arrete l'ecouteur sur le document user du user current
    current_user_store.stopLisenGetUser();
    // deconnection
    await signOut(fire_auth);
    // reset session.user
    $session.user = null;
    //retourne sur la page login
    goto('/login');
  };
</script>

<button on:click={deconnect}>Se deconnecter</button>
