<script lang="ts">
  import { session } from '$app/stores';
  import { condition_gen_store } from '$lib/modules/condition/condition.store';
  import { presentation_store } from '$lib/modules/presentation/presentation.store';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { onMount } from 'svelte';
  import BoxGlobalEntities from '$lib/modules/components/boxs/box-global-entities.svelte';
  import WebappTable from '$lib/modules/webapp/components/webapp-table.svelte';
  import { webapps_store } from '$lib/modules/webapp/store/webapps.store';

  let loader = false;

  onMount(async () => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      current_user_store.getUser($session.user.uid);
    } else {
      // TODO : gerer probleme de connexion user ou de connexion
    }

    // si présentation n'est pas encore request on request
    if ($presentation_store.length === 0) {
      await presentation_store.getPresentation();
    }

    // si condition gen n'est pas encore request on request
    if ($condition_gen_store.length === 0) {
      condition_gen_store.listenConditionGen();
      loader = true;
    } else {
      loader = true;
    }

    // si web app n'est pas encore request on request
    if ($webapps_store.length === 0) {
      webapps_store.listenWebapps();
      loader = true;
    } else {
      loader = true;
    }
  });
</script>

<BoxGlobalEntities>
  {#if loader}
    <!-- partie webapp -->
    <WebappTable />
  {:else}
    <SpinnerLittle />
  {/if}
</BoxGlobalEntities>
