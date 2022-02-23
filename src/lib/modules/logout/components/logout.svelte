<script lang="ts">
  import { goto } from '$app/navigation';
  import { session } from '$app/stores';
  import LogoutSvg from '$lib/modules/components/logout-svg/logout-svg.svelte';
  import {
    presentation_selected_store,
    presentation_store
  } from '$lib/modules/presentation/presentation.store';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { fire_auth } from '$lib/providers/firebase/firebase.service';
  import { signOut, type User } from 'firebase/auth';

  /**
   * deconnexion simple utilisateur
   */
  const deconnect = async () => {
    // on arrete l'ecouteur sur le document user du user current
    current_user_store.stopLisenGetUser();
    // on efface le current user
    current_user_store.resetCurrentUser();
    // reset store presentation et presentationselected
    presentation_store.resetPresentation();
    presentation_selected_store.resetPresentationSelected();
    // deconnection
    await signOut(fire_auth);
    // reset session.user
    $session.user = {} as User;
  };
</script>

<button on:click={deconnect}><LogoutSvg size="w-7 h-7" /></button>
