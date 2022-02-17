<script lang="ts">
  import { session } from '$app/stores';
  import Logout from '$lib/modules/logout/components/logout.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { onMount } from 'svelte';

  onMount(() => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      current_user_store.getUser($session.user.uid);
    }
  });
</script>

<p>connecter</p>

<Logout />
