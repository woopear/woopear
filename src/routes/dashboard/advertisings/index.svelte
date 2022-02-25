<script lang="ts">
  import { session } from '$app/stores';
  import Advertising from '$lib/modules/advertising/components/advertising.svelte';
  import { advertising_store } from '$lib/modules/advertising/store/advertising.store';
  import BoxGlobalEntities from '$lib/modules/components/boxs/box-global-entities.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { onMount } from 'svelte';

  let loader = false;

  onMount(async () => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      current_user_store.getUser($session.user.uid);
    } else {
      // TODO : gerer probleme de connexion user ou de connexion
    }

    if ($advertising_store.length === 0) {
      advertising_store.listenAdvertising();
      loader = true;
    } else {
      loader = true;
    }
  });
</script>

<BoxGlobalEntities>
  <Advertising />
</BoxGlobalEntities>
